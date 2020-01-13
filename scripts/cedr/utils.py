import torch
import random
import numpy


def set_all_seeds(seed):
  '''Just set the seed value for common packages including the standard random'''
  print(f'Setting the seed to {seed}')
  torch.manual_seed(seed)
  if torch.cuda.is_available():
    torch.cuda.manual_seed_all(seed)
  random.seed(seed)
  numpy.random.seed(seed)

