import numpy as np
import torch
from torch.utils.data import Dataset, DataLoader, Subset
import os

class FootDropDataset(Dataset):
    def __init__(self, data_dir, exclude_subj=None):
        """ Load the three .npy files from data_dir, excluding data from exclude_subj
        Convert inputs and labels to torch tensors"""

        inp = torch.from_numpy(np.load(os.path.join(data_dir, 'inputs.npy'))).float()
        lab = torch.from_numpy(np.load(os.path.join(data_dir, 'labels.npy'))).float()
        subject_ids = np.load(os.path.join(data_dir, 'subject_ids.npy'), allow_pickle=True)

        if (exclude_subj is None):
            self.inputs = inp
            self.labels = lab

        else:
            mask = np.array([s not in exclude_subj for s in subject_ids])
            self.inputs = inp[mask]
            self.labels = lab[mask]

    
    def __len__(self):
        """Return total number of windows"""
        return len(self.labels)
    
    def __getitem__(self, idx):
        """Return a single (input_tensor, label_tensor) pair at index idx"""
        return (self.inputs[idx], self.labels[idx])
