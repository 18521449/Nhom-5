# Setup Environment
- [Create Github Repository](https://github.com/18521449/Nhom-5)
- [Install Ubuntu Desktop](https://ubuntu.com/tutorials/install-ubuntu-desktop#11-installation-complete)
- [Install Python 3.6 or later](https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/)
- [Install Opencv-Python Package](https://acodary.wordpress.com/2018/07/21/opencv-cai-dat-opencv-python-tren-windows/)
# Write a "Hello world" app
- Read, Write and Display a video/webcam using OpenCV python
```python
import cv2
import numpy as np

capvideo = cv2.VideoCapture(0)

if (capvideo.isOpened() == False): 

  print("Can't open video")

frame_width = int(capvideo.get(3))

frame_height = int(capvideo.get(4))


out = cv2.VideoWriter('outvideo.avi',cv2.VideoWriter_fourcc('M','J','P','G'), 10, (frame_width,frame_height))


while capvideo.isOpened():

  ret, frame = capvideo.read()

  if ret == True: 
    out.write(frame)
    cv2.imshow('frame',frame)
    # nhan "q" tren ban phim de close record
    if cv2.waitKey(40) == ord('q'):
      break

  else:

    break 

# Closes the windown

capvideo.release()
out.release()

# Closes all the frames

cv2.destroyAllWindows() 
```
