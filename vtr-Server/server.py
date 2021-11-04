from random import randint
from typing import BinaryIO
from flask import Flask, render_template, request, jsonify, Response, send_file
from flask_restful import reqparse, abort, Api, Resource
from PIL import Image
import pymongo
from pymongo import MongoClient
import json
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
from io import StringIO
from io import BytesIO
from PIL import Image, ImageDraw

from werkzeug.wrappers import response


# sys.path.insert(0, "./vtr")
import merge_final as vtr
# from merge_final import merge_face_and_background as vtr
app = Flask(__name__)
api = Api(app)


def random_with_N_digits(n):
    range_start = 10**(n-1)
    range_end = (10**n)-1
    return randint(range_start, range_end)


def trycatch(fn, str):
    try:
        print(f"{str} done: {BinaryIO(fn)}")
    except Exception as e:
        print(f"no {str}")
############################################## THE REAL DEAL ###############################################


@app.route('/', methods=['POST', 'get'])
def home():
    respond = {
        'status': 200,
        'mess': 'server is on'

    }
    return jsonify(respond)


@app.route('/userPicPost', methods=['POST','GET'])
def userPicPost():
    if request.method == 'POST':
        savepath = f"./Upic/saveimage-{random_with_N_digits(16)}.jpg"
        print(request.files, file=sys.stderr)
        clothid = request.form['clothid']
        file = request.files['image'].read()  # byte file

        npimg = np.frombuffer(file, np.uint8)
        img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)

        cv2.imwrite(savepath, img)
        # TODO: vtr merge fn here
        
        the_cloth = getclothsdb(clothid)
        print(f"cloth: {the_cloth}")
        if the_cloth == -1:
            return jsonify({"result": "failed"})
        result = vtr.merge_face_and_background(the_cloth,savepath)
        print(
            f"\n\n\npic: {result}\n\n\n")

        return result
       
    if request.method == 'GET':
        arg = request.args['result']
        print(f"arg get: {arg}")
        return send_file(arg,mimetype ='image/png')



# connecting server with mongodb
cluster = MongoClient("mongodb://localhost:27017")

'''
VTR
 L> CLOTHS
        L> MENS
        L> WOMEN

'''
db = cluster["VTR"]
cloths = db["cloths"]
men = cloths["men"]
women = cloths["women"]


def getclothsdb(id):
    if(id.find("women") == -1):
        cloth = men.find_one({"_id": id})
    else:
        cloth = women.find_one({"_id": id})

    try:
        file = cloth['cloth']
  
        return file
    except Exception as e:
        print(f"cant save image {e}")
        return -1



# get  cloths from data base
@app.route('/getcloths', methods=['get'])
def getcloths():
    # if request['post']
    args = request.args


    print(args['id'])  # For debugging
    try:
        # id = request.form['id']
        id = args['id']
        print(id)
        res = getclothsdb(id)
        if res != -1:
            return send_file(res, mimetype='image/jpg')
        else:
            return jsonify({"result": "failed"})

    except Exception as e:
        return jsonify({"result": "failed"})


# get all cloths from data base
@app.route('/getallcloths', methods=['post', 'get'])
def getallcloths():
    try:
        cloths = []
        cursor = men.find({})
        for document in cursor:
            print(document)
            cloths.append(document)
        return jsonify(cloths)
        # return cursor
    except Exception as e:
        return jsonify({"result": "failed"})

# add cloth to data base
@app.route('/addcloth', methods=['POST'])
def addcloth():
    try:
        tag = request.form['tag']
        description = request.form['description']
        age = request.form['age']
        print(f"res: {tag} , {description}, {age}")
        file = request.files['image'].read()
        if request.form['type'] == 'men':
            id = f"men-{random_with_N_digits(16)}"
            men.insert_one({"_id": id, "tag": tag, "cloth": file,
                           "description": description, "age": age})
        else:
            id = f"women-{random_with_N_digits(16)}"
            women.insert_one(
                {"_id": id, "tag": tag, "cloth": file, "description": description, "age": age})

        return jsonify({"result": "done"})
    except Exception as e:
        return jsonify({"result": "failed"})

if __name__ == "__main__":
    app.run(debug=True, port=3333)

'''
TODO:
1. sending cloth images from mongodg database
2. taking single cloth of database

'''
