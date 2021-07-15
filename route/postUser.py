from flask import Flask, render_template, request, jsonify, Response
from flask_restful import reqparse, abort, Api, Resource
from PIL import Image
import os
import io
import sys
import numpy as np
import cv2
import base64
import jsonpickle
import numpy as np
import cv2

def userPicPost():
    print(request.files, file=sys.stderr)
    file = request.files['image'].read()  # byte file
    npimg = np.fromstring(file, np.uint8)
    img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)
    # Filename
    # filename = 'savedImage.jpg'
    # cv2.imwrite('savedImage.jpg',img)

    # Using cv2.imwrite() method
    # Saving the image
    ######### Do preprocessing here ################
    # img[img > 150] = 0
    # any random stuff do here
    ################################################
    cv2.imwrite('./saveimage.jpg',img)
    img = Image.fromarray(img.astype("uint8"))
    rawBytes = io.BytesIO()

    print(f"raw: {rawBytes}")
    img.save(rawBytes, "JPEG")
    rawBytes.seek(0)
    img_base64 = base64.b64encode(rawBytes.read())
    return jsonify({'status': str(img_base64)})

