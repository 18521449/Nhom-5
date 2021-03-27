import cv2
import numpy as np
import ctypes

def de2hex_floating_point(x):
   return hex(ctypes.c_uint.from_buffer(ctypes.c_float(x)).value)
img_rgb = cv2.imread('image.jpg')
img_resize = cv2.resize(img_rgb, (100, 100), 
               interpolation = cv2.INTER_NEAREST)

# Lay thong tin cua anh
(h, w, d) = img_resize.shape
print("width={}, height={}, depth={}".format(w, h, d))
f = open('/home/pc/Documents/W2/HDL/text.txt', 'w')
for i in range (h):
  for j in range (w):
    b, g, r = img_resize[i][j]
    if(r != 0): r = de2hex_floating_point(r).replace('0x', '')
    else: r = '00000000'
    if(g != 0): g = de2hex_floating_point(g).replace('0x', '')
    else: g = '00000000'
    if(b != 0): b = de2hex_floating_point(b).replace('0x', '')
    else: b = '00000000'
    string = r + g + b + '\n'
    f.write(string)



def rgb2hsv(r, g, b):
  r_d = r / 255
  g_d = g / 255
  b_d = b / 255

  Cmax = max(r_d, g_d, b_d)
  Cmin = min(r_d, g_d, b_d)

  denta = Cmax - Cmin

  #Hue calculation:
  if(denta == 0):
      h = 0
  elif(Cmax == r_d):
      h = 60*(((g_d - b_d)/denta)%6)
  elif(Cmax == g_d):
      h = 60*((b_d - r_d)/denta + 2)
  elif(Cmax == b_d):
      h = 60*((r_d - g_d) + 4)

  #Saturation calculation:
  if(Cmax == 0):
      s = 0
  else:
      s = (denta/Cmax)*100

  #Value calculation:
  v = Cmax * 100
  #Return result
  return h, s, v

f1 = open('text1.txt', 'w')
for i in range (h):
  for j in range (w):
    b, g, r = img_resize[i][j]
    h, s, v = rgb2hsv(r, g, b)
    # if(h !=0): h = de2hex_floating_point(h).replace('0x', '')
    # else: h = '00000000'
    # if(s != 0): s = de2hex_floating_point(s).replace('0x', '')
    # else: s = '00000000'
    # if(v != 0): v = de2hex_floating_point(v).replace('0x', '')
    # else: v = '00000000'
    # string = h +"\" + s +"\t' + v + '\n'
    f1.write(str(h)+'\t'+ str(s) +'\t'+ str(v) + "\n")
#print(img_rgb)

f.close()
f1.close()
cv2.imshow("img_raw", img_resize)
cv2.imwrite('img_resize.jpg',img_resize)
cv2.waitKey(0)