from fpToDec import fpToDec
import numpy as np
import cv2
### PARAMETER RESIZE WALLPAPER
h = 100
w = 100

############## RAW File
img1 = cv2.imread('img_resize.jpg')
# img1 = cv2.resize(img1, (h, w))
img1 = cv2.cvtColor(img1,cv2.COLOR_BGR2HSV)
############## File From HDL
fR = '/home/pc/Documents/W2/HDL/Out_text.txt'
############## File Save HDL Floating to Decimal
ff = open('fbToImage.txt', 'w+')
############## Read file to Var
with open(fR) as f:
    for i in range (3):
       f.readline()
    lines = f.read().splitlines()

count = 0
img = []
for i in range (h):
    T = []
    for j in range (w):
        pixel = lines[count]
        #print([(fpToDec(pixel[:32])/2), (fpToDec(pixel[32:64])*2.55), (fpToDec(pixel[64:])*2.55)], count)
        temp = [np.uint8(round(int(fpToDec(pixel[:32])/2.0))), np.uint8(round(int(fpToDec(pixel[32:64])*2.55))), np.uint8(int(round(fpToDec(pixel[64:])*2.55)))]
        T += [temp]
        ff.write(str(temp)+'\n')
        count += 1
    img += [T]
ff.close()

img = np.array(img)

cv2.imshow('hdlHSV', img)
cv2.imshow('pyHSV', img1)


errorH = 0
errorS = 0
errorV = 0

for (i) in range (h):
    for j in range (w):
        errorH += abs(int(img[i][j][0]) - int(img1[i][j][0]))
        errorS += abs(int(img[i][j][1]) - int(img1[i][j][1]))
        errorV += abs(int(img[i][j][2]) - int(img1[i][j][2]))

l = h*w
errorH /=l
errorS /=l
errorV /=l
print('ERROR H-S-V: ', errorH, errorS, errorV)


# I1 = img.tolist()
# I2 = img1.tolist()

# with open('valueHSVpy.txt', 'w+') as f:
#     for item in I2:
#         f.write("%s\n" % item)

# with open('valueHSVhdl.txt', 'w+') as f:
#     for item in I1:
#         f.write("%s\n" % item)


cv2.waitKey()
cv2.destroyAllWindows()

###########################################################################################
###########################################################################################