# -*- coding: cp1252 -*-
import os, sys
import argparse

import numpy as np
import scipy as sp
from scipy import misc
import matplotlib as mpl
import matplotlib.pyplot as plt

import skimage
import skimage.io as io

import numpy.ma as ma

##Paso 1 - Carga de imágenes
path = '..\input\\'
files = os.listdir(path)

train = list()
test = list()

for i in range(150):
    train.append(io.imread(path+files[i], as_grey=True))

for i in range(150):
    test.append(io.imread(path+files[i+149], as_grey=True))

##Paso 2 - Media y desviación estándard

train = np.array(train)
test = np.array(test)

meanTrain = np.mean(train, axis = 0)
deviationTrain = np.std(train, axis= 0)

#Si se quiere imprimir imágenes de estas dos matrices
misc.imsave('mediana.png', meanTrain)
#misc.imsave('desviacionEstandard.png', deviationTrain)

##Paso 3 - Segmentar los coches restando el modelo de fondo

#Anota los elementos menores al valor de recorte
filtrado = ma.masked_less_equal(meanTrain,0.7)
filtrado.fill_value = 0
print filtrado.filled()
