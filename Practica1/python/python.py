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

import cv2

##Paso 1 - Carga de imágenes
print "Leyendo imágenes"

path = '..\input\\'
files = os.listdir(path)

train = list()
test = list()

for i in range(150):
    train.append(io.imread(path+files[i], as_grey=True))

for i in range(150):
    test.append(io.imread(path+files[i+149], as_grey=True))

##Paso 2 - Media y desviación estándard
print "Calculando media y desviación estándard"

train = np.array(train)
test = np.array(test)

meanTrain = np.mean(train, axis = 0)
deviationTrain = np.std(train, axis= 0)

#Si se quiere imprimir imágenes de estas dos matrices
#misc.imsave('mediana.png', meanTrain)
#misc.imsave('desviacionEstandard.png', deviationTrain)

##Paso 3 y 4 - Segmentar los coches
print "Segmentando los coches"

nImagenes = test.size / test[0].size;
tx = test[0][0].size
ty = test[0].size / tx

alfa = raw_input("Valor de Alfa (si no se pone nada, 1.6 por defecto): ") #Recomendado 1.6
if(alfa == ""):
    alfa = "1.6"

beta = raw_input("Valor de Beta (si no se pone nada, 0.11 por defecto): ") #Recomendado 0.11
if(beta == ""):
    beta = "0.11"

#Se calcula la matriz de desviación
matrixDesviacion = np.add(deviationTrain,float(beta))
matrixDesviacion = np.multiply(matrixDesviacion,float(alfa))

frames = list()

for i in range(nImagenes):
    #Se substrae el mean
    matriz = np.subtract(test[i],meanTrain)
    #Se hace valor absoluto
    matriz = np.absolute(matriz)
    #Se sustraen los valores máximos de desviación
    matriz = np.subtract(matriz,matrixDesviacion)
    #Se ocultan los elementos que sean mayores a 0
    matriz = ma.masked_greater(matriz,0)
    #Se multiplica por 0 - Así los valores <0 se quedan en 0
    matriz = np.multiply(matriz,0)
    #Se hace valor absoluto de nuevo
    #- Es algo decorativo, algunos elementos se quedan en -0#
    matriz = np.absolute(matriz)
    #Los elementos que no son 0 se convierten en 1
    matriz = matriz.filled(fill_value = 1)

    frames.append(matriz);

    #Si se quieren imprimir imagenes del proceso
    #misc.imsave('pulido['+str(i)+'].png', matriz)

##Paso 5 - Grabar un video
#Se utiliza OpenCV
print "Creando video"

print "Por favor, seleccione un codec en la ventana emergente"
writer = cv2.VideoWriter("output-python.avi", -1, 30, (tx,ty))

for i in frames:
    writer.write(i)

writer.release()

print "Ejecución finalizada"

