import struct
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
from keras import backend as K
from tensorflow import keras
import cv2
import ctypes
from ctypes import *
#---------------------------------------------
def fpToDec(x):
    if x == '00000000000000000000000000000000':
        return int(0)
    
    sign = x[0]
    exp = x[1:9]
    mantise = '1' + x[9:]
    S = 0
    P = 0

    ## Tìm số mũ
    for i in range (8):
        P += int(exp[7-i])*(2**i)
    P = P - 127
    ## Tìm dạng chuẩn hóa
    for i in range (24):
        S += int(mantise[i])*(2**-i)
    ## Tìm dạng Dec giá trị tuyệt đối
    while (P!=0):
        if P<0:
            S /= 2
            P += 1
        else:
            S *=2
            P -= 1
    
    if sign == '1':
        return int(-S)
    else:
        return int(S)



#--------------------------------------------------------------------------------------------
def feature_map_show(x, title):
    num_out_channels = x.shape[2]
    num_diagram_col = 4
    if num_out_channels >= 16:
        num_diagram_col = 8
    num_diagram_row = np.ceil(num_out_channels / num_diagram_col)

    num_diagram_col = int(num_diagram_col)
    num_diagram_row = int(num_diagram_row)

    fig, axs = plt.subplots(
        nrows=num_diagram_row,
        ncols=num_diagram_col,
        figsize=(7 * num_diagram_col, 5 * num_diagram_row)
    )

    for i in range(num_out_channels):
        row = i // num_diagram_col
        col = i  % num_diagram_col

        axs[row][col].imshow(x[:, :, i], cmap='gray')
        axs[row][col].axis('off')

    fig.suptitle(title, fontsize=30)
    fig.savefig('D:\CE434\code_py\script\moto1\{:s}.png'.format(title))
#----------------------------------------------------------------------------------------

base_model = keras.models.load_model('model_trainVGG16.h5')

path = 'D:\CE434\code_py\script\Anh_test\moto_1.jpg'
x = cv2.imread(path)
x = cv2.resize(x,(112,112), interpolation= cv2.INTER_AREA)
# x = cv2.cvtColor(x, cv2.COLOR_BGR2RGB)
x = x /255.0
x = np.asarray(x) 
x = np.expand_dims(x, axis=0)

#-------------------------------------------------------------------------------------------
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
# glopool = base_model.layers[18]

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
# glob = glopool(pool5)

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
#----------------------------------------------------------------------------------------




feature_map_show(pool5, "KERAS_moto1_block5")

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

layer = 64
img_size = 3
size = (img_size, img_size)

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
accu = 0
f = open('D:\CE434\code_py\script\moto1\moto1_data_out_b5.txt', 'r')
f1 = open('D:\CE434\code_py\script\moto1\moto1_RTL_block5.txt', 'w+')
f2 = open('D:\CE434\code_py\script\moto1\moto1_PY_block5.txt', 'w+')
# f3 = open('D:\CE434\code_py\script\HEX\moto1_block5_HEX.txt', 'w+')
t = f.readline()
t = f.readline()
t = f.readline()
for k in range(0, layer):
    # f = open('kernel' + str(k+1) + '.txt', 'r')
    for i in range(size[0]):
        for j in range(size[1]):
            t = f.readline()
            x = convert_HEX(t)  
            # x = float(bintofloat(t))
            f1.write(str(x)+'\n')
            f2.write(str(pool5[i][j][k])+'\n')
            # f3.write(dec2hex_fp(pool5[i][j][k])+'\n')
            accu += (x- pool5[i][j][k])*(x - pool5[i][j][k])
            pool5[i][j][k] = x
f.close()
f1.close()
f2.close()
# f3.close()
print("Mean square error:",accu/(img_size*img_size*layer))

feature_map_show(pool5, "RTL_moto1_block5")
