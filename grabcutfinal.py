# import the necessary packages
import time

import cv2
import numpy as np
import argparse
import os

face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", type=str,
	default=os.path.sep.join(["images", "pfp.jpg"]),
	help="path to input image that we'll apply GrabCut to")
ap.add_argument("-c", "--iter", type=int, default=10,
	help="# of GrabCut iterations (larger value => slower runtime)")
args = vars(ap.parse_args())

img = cv2.imread('images/pfp.JPG')

sp = img.shape
print(sp)
if(max(sp) > 800):
    img = cv2.resize(img, (0, 0), fx=0.5, fy=0.5)
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

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
print(x, y, w, h)
mask = np.zeros(img.shape[:2], dtype="uint8")

rect = (x, y, x1, y1)

fgModel = np.zeros((1, 65), dtype="float")
bgModel = np.zeros((1, 65), dtype="float")

start = time.time()
(mask, bgModel, fgModel) = cv2.grabCut(img, mask, rect, bgModel,
	fgModel, iterCount=args["iter"], mode=cv2.GC_INIT_WITH_RECT)
end = time.time()
print("[INFO] applying GrabCut took {:.2f} seconds".format(end - start))

values = (
	("Definite Background", cv2.GC_BGD),
	("Probable Background", cv2.GC_PR_BGD),
	("Definite Foreground", cv2.GC_FGD),
	("Probable Foreground", cv2.GC_PR_FGD),
)

for (name, value) in values:

	print("[INFO] showing mask for '{}'".format(name))
	valueMask = (mask == value).astype("uint8") * 255

	#cv2.imshow(name, valueMask)
	cv2.waitKey(0)

	outputMask = np.where((mask == cv2.GC_BGD) | (mask == cv2.GC_PR_BGD),
						  0, 1)

	outputMask = (outputMask * 255).astype("uint8")

	output = cv2.bitwise_and(img, img, mask=outputMask)
	#cv2.imshow("Input", img)
	#cv2.imshow("GrabCut Mask", outputMask)
	cv2.imshow("GrabCut Output", output)
	cv2.waitKey(0)
