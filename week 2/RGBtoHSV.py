import cv2
import numpy as np
import math
def rgb_to_hsv(r, g, b): 
  
   
    r, g, b = r / 255.0, g / 255.0, b / 255.0
  
    # h, s, v = hue, saturation, value 
    cmax = max(r, g, b)    # maximum of r, g, b 
    cmin = min(r, g, b)    # minimum of r, g, b 
    diff = cmax-cmin       # diff of cmax and cmin. 
  
    # if cmax and cmax are equal then h = 0 
    if cmax == cmin:  
        h = 0
      
    # if cmax equal r then compute h 
    elif cmax == r:  
        h = (60 * ((g - b) / diff) + 360) % 360
  
    # if cmax equal g then compute h 
    elif cmax == g: 
        h = (60 * ((b - r) / diff) + 120) % 360
  
    # if cmax equal b then compute h 
    elif cmax == b: 
        h = (60 * ((r - g) / diff) + 240) % 360
  
    # if cmax equal zero 
    if cmax == 0: 
        s = 0
    else: 
        s = (diff / cmax) * 100
  
    # compute v 
    v = cmax * 100
    return h, s, v 
  

imgraw = cv2.imread("image.jpg")
cv2.imshow('original image',imgraw)

image_resize = cv2.resize(imgraw, (50, 50), 
               interpolation = cv2.INTER_NEAREST)

# print(image_resize.shape)
# print(image_resize)


# cv2.waitKey(0)
fobj = open('textimage.txt', 'w+')
for i in range(50):
    for j in range(50):
        px = image_resize[i][j]
        B = '{0:08b}'.format(px[0])
        G = '{0:08b}'.format(px[1])
        R = '{0:08b}'.format(px[2])
        fobj.write(R+G+B+'\n')

fobj.close()


# image_resize.transpose(2,0,1).reshape(3,-1)
# HSV_img = cv2.cvtColor(image_resize,cv2.COLOR_BGR2HSV)
# cv2.imshow('HSV_image', HSV_img)
# cv2.waitKey(0)



px1 = np.zeros((50,50))
img_hsv = image_resize.copy()
for i in range (50):
    for j in range (50): 
        img_hsv[i,j] = rgb_to_hsv(img_hsv[i,j,2], img_hsv[i,j,1], img_hsv[i,j,0])


cv2.imwrite('frame_hsv.jpg',img_hsv)
cv2.imshow("frame_hsv", img_hsv)
cv2.waitKey(0)
cv2.destroyAllWindows()







