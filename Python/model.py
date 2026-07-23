import torch
import torch.nn as nn


class FootDropCNN(nn.Module):
    """
    CNN -> LSTM binary intent classifier for a 320 ms window @100 Hz (32 samples).

    Data flow (with defaults, odd kernels + 'same' padding for clean /2 pooling):
        (B, 2, 32)                       2 channels: TA envelope, Shank Gy
          conv1 (k=5, pad=2) -> ReLU -> MaxPool/2   -> (B, c1, 16)
          conv2 (k=3, pad=1) -> ReLU -> MaxPool/2   -> (B, c2,  8)
          permute                                    -> (B, 8, c2)
          LSTM(hidden) -> last hidden state          -> (B, hidden)
          Dropout -> Linear(hidden, 1)               -> (B, 1)   single logit

    Width knobs (spend FPGA headroom here, NOT on depth):
        c1, c2      : conv kernels/filters per layer   (e.g. 16/32 baseline, 24/48 or 32/48 wider)
        lstm_hidden : LSTM hidden width
        k1, k2      : conv kernel sizes (keep ODD so padding=k//2 preserves length -> clean pooling)
        dropout     : regularization for the LSTM output (helps cross-subject/LOSO generalization)
    """

    def __init__(self, in_ch=2, c1=16, c2=32, lstm_hidden=32,
                 k1=5, k2=3, dropout=0.3):
        super().__init__()
        assert k1 % 2 == 1 and k2 % 2 == 1, "use odd kernels so padding=k//2 preserves length"

        # CNN layers ('same' padding via k//2 on odd kernels keeps length exact)
        self.conv1 = nn.Conv1d(in_ch, c1, kernel_size=k1, padding=k1 // 2)
        self.conv2 = nn.Conv1d(c1,    c2, kernel_size=k2, padding=k2 // 2)
        self.pool  = nn.MaxPool1d(kernel_size=2)
        self.relu  = nn.ReLU()

        # LSTM over the pooled time axis (8 steps), take the final hidden state
        self.lstm  = nn.LSTM(input_size=c2, hidden_size=lstm_hidden,
                             num_layers=1, batch_first=True)

        # Regularized output head
        self.drop  = nn.Dropout(dropout)
        self.fc    = nn.Linear(lstm_hidden, 1)

    def forward(self, x):
        # x: (batch, 2, 32)
        x = self.pool(self.relu(self.conv1(x)))   # (batch, c1, 16)
        x = self.pool(self.relu(self.conv2(x)))   # (batch, c2, 8)

        # (batch, channels, time) -> (batch, time, features) for the LSTM
        x = x.permute(0, 2, 1)                     # (batch, 8, c2)

        _, (h_n, _) = self.lstm(x)                 # h_n: (1, batch, hidden)
        x = self.drop(h_n.squeeze(0))              # (batch, hidden)
        x = self.fc(x)                             # (batch, 1)
        return x
