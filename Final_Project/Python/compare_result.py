import struct
from PIL import Image
import numpy as np
from numpy.core.numeric import full

from tensorflow import keras
import cv2
import ctypes
from ctypes import *
base_model = keras.models.load_model('model_trainVGG16.h5')

f = open('D:/CE434/code_py/script/result_RTL/result_moto1.txt', 'r')
path = 'D:\CE434\code_py\script\Anh_test\moto_1.jpg'
x = cv2.imread(path)
x = cv2.resize(x,(112,112), interpolation= cv2.INTER_AREA)
x = x /255.0
x = np.asarray(x) 
x = np.expand_dims(x, axis=0)

conv1 = base_model.layers[0]
conv2 = base_model.layers[1]
maxpool1 = base_model.layers[2]
conv3 = base_model.layers[3]
conv4 = base_model.layers[4]
maxpool2 = base_model.layers[5]
conv5 = base_model.layers[6]
conv6 = base_model.layers[7]
conv7 = base_model.layers[8]
maxpool3 = base_model.layers[9]
conv8 = base_model.layers[10]
conv9 = base_model.layers[11]
conv10 = base_model.layers[12]
maxpool4 = base_model.layers[13]
conv11 = base_model.layers[14]
conv12 = base_model.layers[15]
conv13 = base_model.layers[16]
maxpool5 = base_model.layers[17]
flatten = base_model.layers[18]
fc1 = base_model.layers[19]
fc2 = base_model.layers[20]
fc3 = base_model.layers[21]


lay1 = conv1(x)
lay2 = conv2(lay1)
pool1 = maxpool1(lay2)
lay3 = conv3(pool1)
lay4 = conv4(lay3)
pool2 = maxpool2(lay4)
lay5 = conv5(pool2)
lay6 = conv6(lay5)
lay7 = conv7(lay6)
pool3 = maxpool3(lay7)
lay8 = conv8(pool3)
lay9 = conv9(lay8)
lay10 = conv10(lay9)
pool4 = maxpool4(lay10)
lay11 = conv11(pool4)
lay12 = conv12(lay11)
lay13 = conv13(lay12)
pool5 = maxpool5(lay13)
flat= flatten(pool5)
full1 = fc1(flat)
full2 = fc2(full1)
full3 = fc3(full2)

x = x.squeeze()

lay1 = lay1.numpy()
lay1 = lay1.squeeze()

lay2 = lay2.numpy()
lay2 = lay2.squeeze()

pool1 = pool1.numpy()
pool1 = pool1.squeeze()

lay3 = lay3.numpy()
lay3 = lay3.squeeze()

lay4 = lay4.numpy()
lay4 = lay4.squeeze()

pool2 = pool2.numpy()
pool2 = pool2.squeeze()

lay5 = lay5.numpy()
lay5 = lay5.squeeze()

lay6 = lay6.numpy()
lay6 = lay6.squeeze()

lay7 = lay7.numpy()
lay7 = lay7.squeeze()

pool3 = pool3.numpy()
pool3 = pool3.squeeze()

lay8 = lay8.numpy()
lay8 = lay8.squeeze()

lay9 = lay9.numpy()
lay9 = lay9.squeeze()

lay10 = lay10.numpy()
lay10 = lay10.squeeze()

pool4 = pool4.numpy()
pool4 = pool4.squeeze()

lay11 = lay11.numpy()
lay11 = lay11.squeeze()

lay12 = lay12.numpy()
lay12 = lay12.squeeze()

lay13 = lay13.numpy()
lay13 = lay13.squeeze()

pool5 = pool5.numpy()
pool5 = pool5.squeeze()

flat = flat.numpy()
flat = flat.squeeze()

full1 = full1.numpy()
full1 = full1.squeeze()


full2 = full2.numpy()
full2 = full2.squeeze()

full3 = full3.numpy()
full3 = full3.squeeze()

kernel1 = fc1.get_weights()[0]
bias1 = fc1.get_weights()[1]


def bintofloat(value):
    temp = int(value, 2)
    return struct.unpack('f', struct.pack('I', temp))[0]
def dec2hex_fp(x):
    if (x != 0):
        return hex(ctypes.c_uint.from_buffer(ctypes.c_float(x)).value)[2:]  # bo ki tu 0x o dau chuoi hex
    else: 
        return '00000000'
def convert_HEX(s):
    i = int(s, 16)                   
    cp = pointer(c_int(i))           
    fp = cast(cp, POINTER(c_float))  
    return fp.contents.value  
def softmax(Z):
    e_Z = np.exp(Z)
    A = e_Z / e_Z.sum(axis = 0)
    return A
accu = 0
layer = 2

# f = open('D:/CE434/code_py/script/result_RTL/result_car1.txt', 'r')
t = f.readline()
t = f.readline()
t = f.readline()
arr = []
for i in range (0, layer):
    t = f.readline()
    arr += [convert_HEX(t)]
x = softmax(arr)
# f1 = open('D:/CE434/code_py/script/car1/moto3_flaten_hex.txt', 'w+')
# f2 = open('D:/CE434/code_py/script/car1/fc2_RTL.txt', 'w+')
print("KERAS", "\t\t", "RTL")
for i in range (0, layer):
#   t = f.readline()
# #   x = float(bintofloat(t))
#   x = convert_HEX(t)
  accu += (x[i] - full3[i])*(x[i] - full3[i])
#   f1.write(str(flat[i])+'\n')
#   f2.write(str(x)+'\n')
#   print(full3[i])
  if (full3[i] != 0):
    print(full3[i], "\t",x[i])
    # f1.write(str(flat[i])+'\n')
  else:
    print(full3[i], "\t\t",x[i])
f.close()
# f1.close()
# f2.close()
print("Mean square error:",accu/layer)
a=np.array( [[x[0], x[1]]]) #moto 1
print(a)
x = np.argmax(a,axis=1)
print(x)
if x == 1:
  print('moto')
else:
  print('car')