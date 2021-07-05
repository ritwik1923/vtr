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
import time

# sys.path.insert(0, "./vtr")
import merge_final as vtr
# from merge_final import merge_face_and_background as vtr
app = Flask(__name__)
api = Api(app)
from random import randint


def random_with_N_digits(n):
    range_start = 10**(n-1)
    range_end = (10**n)-1
    return randint(range_start, range_end)

############################################## THE REAL DEAL ###############################################
@app.route('/userPicPost', methods=['POST'])
def userPicPost():
    # vtr.deemo()
    savepath = f"./Upic/saveimage-{random_with_N_digits(16)}.jpg"
    print("\n\n")
    print(request.files, file=sys.stderr)
    print("\n\n")
    file = request.files['image'].read()  # byte file
    print("\n\n")
    npimg = np.frombuffer(file, np.uint8)
    print("\n\n")
    img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

    cv2.imwrite(savepath,img)
    # TODO: vtr merge fn here
    # vtr.merge_face_and_background(the_cloth,'.'+savepath[4:])
    # vtr.vtr()
    # time.sleep(10)
    the_cloth = "./cloths/DM333.png"
    print(f"\n\n\npic: {vtr.merge_face_and_background(the_cloth,savepath)}\n\n\n")
    img = Image.fromarray(img.astype("uint8"))
    rawBytes = io.BytesIO()

    print(f"raw: {rawBytes}")
    img.save(rawBytes, "JPEG")
    rawBytes.seek(0)
    img_base64 = base64.b64encode(rawBytes.read())
    respond = {
        'status':200,
        'image': str(img_base64)

    }
    return jsonify(respond)


if __name__ == "__main__":
    app.run(debug=True)
