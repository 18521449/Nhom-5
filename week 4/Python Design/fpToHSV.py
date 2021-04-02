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
fR = '/home/nguyentienluan/Documents/Lab1_W2/HDL_RGB2HSV/Out_text.txt'
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

def rgb_to_hsv(r, g, b):
    r = r / 255.0
    g = g / 255.0
    b = b / 255.0
    mx = max(r, g, b)
    mn = min(r, g, b)
    diff = mx - mn
    if (mx == mn):
        h = 0
    elif mx == r:
        h = abs(g-b)*43/diff
    elif mx == g:
        h = abs(g-b)*43/diff + 85
    elif mx == b:
        h = abs(g-b)*43/diff + 171
    if mx == 0:
        s = 0
    else:
        s = (diff / mx)
    v = mx
    return h, s, v
img_t = cv2.imread('img_resize.jpg')
(height, width,depth) = img_t.shape
h_a = [[0 for x in range(width)] for y in range(height)]
s_a = [[0 for x in range(width)] for y in range(height)]
v_a = [[0 for x in range(width)] for y in range(height)]

for i in range(0,height):
    for j in range(0,width):
        (B, G, R) = img_t[i][j]
        h_t, s_t, v_t = rgb_to_hsv(R, G, B)
        h_t = (round(255*h_t/360))
        s_t = (round(s_t*255))
        v_t = (round(v_t*255))
        h_a[i][j] = h_t
        s_a[i][j] = s_t
        v_a[i][j] = v_t

h_a = np.array(h_a)
s_a = np.array(s_a)
v_a = np.array(v_a)
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