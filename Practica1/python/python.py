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

##Paso 1 - Carga de im�genes
print "Leyendo im�genes"

path = '..\input\\'
files = os.listdir(path)

train = list()
test = list()

for i in range(150):
    train.append(io.imread(path+files[i], as_grey=True))

for i in range(150):
    test.append(io.imread(path+files[i+149], as_grey=True))

##Paso 2 - Media y desviaci�n est�ndard
print "Calculando media y desviaci�n est�ndard"

train = np.array(train)
test = np.array(test)

meanTrain = np.mean(train, axis = 0)
deviationTrain = np.std(train, axis= 0)

#Si se quiere imprimir im�genes de estas dos matrices
#misc.imsave('mediana.png', meanTrain)
#misc.imsave('desviacionEstandard.png', deviationTrain)

##Paso 3 y 4 - Segmentar los coches
print "Segmentando los coches"

nImagenes = test.size / test[0].size;


alfa = raw_input("Valor de Alfa: ") #Recomendado 1.6
beta = raw_input("Valor de Beta: ") #Recomendado 0.11

#Se calcula la matriz de desviaci�n
matrixDesviacion = np.add(deviationTrain,float(beta))
matrixDesviacion = np.multiply(matrixDesviacion,float(alfa))

for i in range(nImagenes):
    #Se substrae el mean
    matriz = np.subtract(train[i],meanTrain)
    #Se hace valor absoluto
    matriz = np.absolute(matriz)
    #Se sustraen los valores m�ximos de desviaci�n
    matriz = np.subtract(matriz,matrixDesviacion)
    #Se ocultan los elementos que sean mayores a 0
    matriz = ma.masked_greater(matriz,0)
    #Se multiplica por 0 - As� los valores <0 se quedan en 0
    matriz = np.multiply(matriz,0)
    #Se hace valor absoluto de nuevo
    #- Es algo decorativo, algunos elementos se quedan en -0#
    matriz = np.absolute(matriz)
    #Los elementos que no son 0 se convierten en 1
    matriz = matriz.filled(fill_value = 1)

    #Si se quieren imprimir imagenes del proceso
    #misc.imsave('pulido['+str(i)+'].png', matriz)
