import numpy as np
import cv2 as cv
face_cascade = cv.CascadeClassifier('haarcascade_frontalface_default.xml')
img = cv.imread('images/vk4.jpg')

sp = img.shape
print(sp)
if(max(sp) > 800):
    img = cv.resize(img, (0, 0), fx=0.5, fy=0.5)
gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

faces = face_cascade.detectMultiScale(gray, 1.3, 5)
print(faces)
x = faces[0][0]
y = faces[0][1]
w = faces[0][2]
h = faces[0][3]
x1 = x+w
y1 = y+h
print(x, y, x1, y1)
h_upper = int((h*50)/100)
h_lower = int((h*25)/100)
w = int((w*10)/100)
x -= w
y = y-h_upper
x1 = x1+w
y1 = y1+h_lower
print(x, y, x1, y1)

img1 = img[y:y1, x:x1]
cv.rectangle(img, (x, y), (x1, y1), (255, 0, 0), 2)
cv.imshow('face', img1)
cv.imshow('image', img)
cv.waitKey(0)
cv.destroyAllWindows()
