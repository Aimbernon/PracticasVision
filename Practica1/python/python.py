import os, sys
import argparse

import numpy as np
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt

import skimage
import skimage.io as io

path = "..\input"
# Mostrar imagenes de una carpeta
files = os.listdir(path)

for file in files:
    print file

#for file in files:
#    skimage.data_dir
#    io.imread("C:/Users/user/Documents/VC/P1/highway/highway/input/"+file, as_grey=True)
