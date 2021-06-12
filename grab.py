import cv2
import numpy as np
from matplotlib import pyplot as plt
face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
image_bgr = cv2.imread('images/pfp.jpg')
image_rgb = cv2.cvtColor(image_bgr, cv2.COLOR_BGR2RGB)

sp = image_rgb.shape
print(sp)
if (max(sp) > 800):
    image_rgb = cv2.resize(image_rgb, (0, 0), fx=0.5, fy=0.5)
gray = cv2.cvtColor(image_rgb, cv2.COLOR_BGR2GRAY)

faces = face_cascade.detectMultiScale(gray, 1.3, 5)
print(faces)
x = faces[0][0]
y = faces[0][1]
w = faces[0][2]
h = faces[0][3]
x1 = x + w
y1 = y + h
print(x, y, x1, y1)
h_upper = int((h * 50) / 100)
h_lower = int((h*25) / 100)
w = int((w*10) / 100)
x -= w
y = y - h_upper
x1 = x1 + w
y1 = y1 + h_lower
print(x, y, x1, y1)













rectangle = (x, y, x1, y1)
# 600, 550, 1150, 2000
mask = np.zeros(image_rgb.shape[:2], np.uint8)

bgdModel = np.zeros((1, 65), np.float64)
fgdModel = np.zeros((1, 65), np.float64)

cv2.grabCut(image_rgb, mask, rectangle, bgdModel, fgdModel, 5, cv2.GC_INIT_WITH_RECT)

mask_2 = np.where((mask == 2) | (mask == 0), 0, 1).astype('uint8')

image_rgd_nobg = image_rgb * mask_2[:, :, np.newaxis]

plt.imshow(image_rgd_nobg), plt.axis('off')
plt.show()