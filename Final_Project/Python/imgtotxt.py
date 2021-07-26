
### PARAMETER RESIZE WALLPAPER
h = 112
w = 112

###########################################################################################
###########################################################################################
def decToFP(x):
    if x==0:
        return '00000000000000000000000000000000'

    signFP = ''
    leftSide = 0
    rightSide = 0
    exp = 0
    mantise = ''
    ## Xét dấu 
    if (x<0):
        signFP = '1'
    else:
        signFP = '0'

    if (x<0):
        x = -x
    else:
        x = x
    
    while(x<1 or x>2):
        if (x<1):
            x *= 2
            leftSide += 1
        else:
            x /= 2
            rightSide += 1
    
    exp = (rightSide-leftSide) + 127

    i = 0
    for i in range (24):
        if (x>=1):
            x -= 1
            mantise += '1'
        else:
            mantise += '0'
        x *= 2

    return signFP + str(format(exp, '08b')) + mantise[1:]

###########################################################################################
###########################################################################################
def de2hex_floating_point(x):
   return hex(ctypes.c_uint.from_buffer(ctypes.c_float(x)).value)


def dec2hex_fp(x):
    if (x != 0):
        return hex(ctypes.c_uint.from_buffer(ctypes.c_float(x)).value)[2:]  # bo ki tu 0x o dau chuoi hex
    else: 
        return '00000000'
######################################################################
import numpy as np
import cv2
import ctypes
filE = open('D:\CE434\code_py\script\Test\moto3.txt', 'a+')

img = cv2.imread('moto_3.jpg')

img = cv2.resize(img, (h, w),interpolation = cv2.INTER_NEAREST)

for i in range (h):
    for j in range (w):
        t = dec2hex_fp(img[i][j][0]/255.0)+'\n'
        filE.write(t)
for i in range (h):
    for j in range (w):
        t = dec2hex_fp(img[i][j][1]/255.0)+'\n'
        filE.write(t)
for i in range (h):
    for j in range (w):
        t = dec2hex_fp(img[i][j][2]/255.0)+'\n'
        filE.write(t)
print('Complete')

filE.close()
cv2.imshow('z', img)
cv2.waitKey()


###########################################################################################
###########################################################################################
