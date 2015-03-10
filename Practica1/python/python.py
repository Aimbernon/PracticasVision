# -*- coding: cp1252 -*-
import os, sys
import argparse

import numpy as np
import scipy as sp
import matplotlib as mpl
import matplotlib.pyplot as plt

import skimage
import skimage.io as io


##Paso 1 - Carga de imágenes
path = '..\input\\'
files = os.listdir(path)

train = list()
test = list()

for i in range(150):
    print (path+files[i], "TRAIN")
    train.append(io.imread(path+files[i], as_grey=True))

for i in range(150):
    print (path+files[i+150], "TEST")
    test.append(io.imread(path+files[i+149], as_grey=True))


