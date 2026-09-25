"""
Subject-specific fine-tuning of the ENABL3S FootDropCNN on own recordings.

    python finetune.py --data own_dataset_sliding                # default: warm-start from best_model.pt
    python finetune.py --data own_dataset_sliding --from-scratch # sanity baseline: no pretraining

Steps:
  1. Zero-shot: evaluate best_model.pt on the own data before touching it.
     (This number tells you how far the deployment distribution is from ENABL3S.)
  2. Split WITHOUT leakage. Windows overlap at a 1-sample stride, so a random split
     would put near-identical copies in train and val. Instead:
        - >= MIN_TRIALS_FOR_HOLDOUT walking trials -> hold out whole trial(s)
        - otherwise -> hold out the last VAL_FRAC of time within every trial
  3. Fine-tune at a low LR (all layers; the model is ~10k params, freezing buys nothing),
     with the same recall-favoring pos_weight loss as train.py.
  4. Save the best-F1 checkpoint to best_model_finetuned.pt.

To deploy: copy best_model_finetuned.pt over best_model.pt and re-run export_golden.py
so the weight header, goldens and checkpoint sha256 all come from one file.
"""
import argparse
import re
from pathlib import Path

import numpy as np
import torch
import torch.nn as nn
from sklearn.metrics import f1_score, precision_score, recall_score
from torch.utils.data import DataLoader, TensorDataset

from model import FootDropCNN

HERE = Path(__file__).resolve().parent
PRETRAINED = HERE / "best_model.pt"
C1, C2, LSTM_HIDDEN, DROPOUT = 16, 32, 32, 0.3     # must match the checkpoint

EPOCHS       = 30
LR           = 2e-4          # ~5x lower than train.py; warm start
WEIGHT_DECAY = 1e-4
BATCH_SIZE   = 64
VAL_FRAC     = 0.25          # time-based holdout fraction when too few trials
MIN_TRIALS_FOR_HOLDOUT = 3   # hold out whole trials once you have this many
BASELINE_RE  = r"^standing_still"
SEED         = 123

def evaluate(model, loader):
    model.eval(); P, L = [], []
    with torch.no_grad():
        for x, y in loader:
            P.append((model(x).squeeze(1) > 0).int()); L.append(y.int())
    P, L = torch.cat(P).numpy(), torch.cat(L).numpy()
    return f1_score(L, P, zero_division=0), precision_score(L, P, zero_division=0), recall_score(L, P, zero_division=0)

def split(trial_ids, t0):
    walk = sorted({t for t in trial_ids if not re.match(BASELINE_RE, t)})
    if len(walk) >= MIN_TRIALS_FOR_HOLDOUT:
        n_hold = max(1, round(len(walk) * VAL_FRAC))
        held = set(walk[-n_hold:])                      # latest trials held out
        val = np.array([t in held for t in trial_ids])
        how = f"held-out trial(s): {sorted(held)}"
    else:
        val = np.zeros(len(trial_ids), bool)
        for t in walk:                                  # last VAL_FRAC of each trial's time
            m = trial_ids == t
            cut = np.quantile(t0[m], 1 - VAL_FRAC)
            val |= m & (t0 >= cut)
        how = f"last {VAL_FRAC:.0%} of time in each of {len(walk)} trial(s)"
    return ~val, val, how

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--data", default="own_dataset_sliding")
    ap.add_argument("--from-scratch", action="store_true")
    ap.add_argument("--out", default="best_model_finetuned.pt")
    args = ap.parse_args()
    torch.manual_seed(SEED)

    d = Path(args.data)
    X = torch.from_numpy(np.load(d / "inputs.npy")).float()
    y = torch.from_numpy(np.load(d / "labels.npy")).float()
    trial_ids = np.load(d / "trial_ids.npy", allow_pickle=True)
    t0 = np.load(d / "window_t0.npy")

    tr, va, how = split(trial_ids, t0)
    print(f"Split: {how}  ->  train {tr.sum()} (+{int(y[tr].sum())})  val {va.sum()} (+{int(y[va].sum())})")
    train_loader = DataLoader(TensorDataset(X[tr], y[tr]), batch_size=BATCH_SIZE, shuffle=True, drop_last=True)
    val_loader   = DataLoader(TensorDataset(X[va], y[va]), batch_size=BATCH_SIZE)

    model = FootDropCNN(c1=C1, c2=C2, lstm_hidden=LSTM_HIDDEN, dropout=DROPOUT)
    if not args.from_scratch:
        model.load_state_dict(torch.load(PRETRAINED, map_location="cpu", weights_only=True))
        f1, p, r = evaluate(model, val_loader)
        print(f"Zero-shot ENABL3S checkpoint on own val: F1 {f1:.3f}  P {p:.3f}  R {r:.3f}")

    num_pos, num_neg = (y[tr] == 1).sum().item(), (y[tr] == 0).sum().item()
    criterion = nn.BCEWithLogitsLoss(pos_weight=torch.tensor([num_neg / num_pos]))
    opt = torch.optim.Adam(model.parameters(), lr=LR, weight_decay=WEIGHT_DECAY)

    best = 0.0
    for ep in range(EPOCHS):
        model.train(); run = 0.0
        for xb, yb in train_loader:
            loss = criterion(model(xb).squeeze(1), yb)
            opt.zero_grad(); loss.backward(); opt.step(); run += loss.item()
        f1, p, r = evaluate(model, val_loader)
        print(f"Epoch {ep + 1:2d}/{EPOCHS}  train loss {run / len(train_loader):.4f}  "
              f"val F1 {f1:.3f}  P {p:.3f}  R {r:.3f}")
        if f1 > best:
            best = f1; torch.save(model.state_dict(), args.out)
            print(f"  -> saved {args.out} (F1 {best:.3f})")
    print("Done. Best val F1:", round(best, 3))

if __name__ == "__main__":
    main()
