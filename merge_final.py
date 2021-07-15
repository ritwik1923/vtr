


# Takes the "the_face" argument which contains the location of the face
# Takes the "the_cloth" argument which contains the location of the cloth
"""
Todo:
Please check if the arguments can be passed as strings
Also check line:28 and line:34
Whether the function Image.open() is able to read the variables the_cloth and the_face
issue: 1. not saving with jpg formate
2. 

"""
from PIL import Image
# import cv2
import sys
import asyncio
import random
import time
# print(f"1st: {sys.argv[1]}, 2nd:{sys.argv[2]}")
# print(f"1st: {sys.argv[0]}")
from grabcut_bbox import ExtractFace

# the_cloth = "./cloths/DM333.png"
# the_cloth = "./cloths/66.png"
# the_face = "./faces/rwk._face.jpg"
# the_face = "pictures\undefined-1624445720485.jpg"
# the_face = "./faces/"
# the_face = "./faces/vkr.png"
# the_face = "./faces/priyanka_face.jpg"
# the_face = "./faces/myimage1._face.jpg"
# the function
# class VTR:
    
#     def __init__(self, pcloth, pface):
#         self.the_cloth = pcloth
#         self.the_face = pface

# async def merge_face_and_background(the_cloth,the_face):
    # the_face = await ExtractFace(the_face,'M')
def merge_face_and_background(the_cloth,the_face):
    print(f"merge: {the_cloth,the_face}")
    # return
    the_face = ExtractFace(the_face,'M')
    # time.sleep(8)    
    print(f"face: {the_face}")
    pass
    ff = 150 
    cc = ff*2.5
    # Opening the primary image (used in background)
    bg = Image.open(r"./images/bg.jpg").convert("RGBA")
    bg = bg.resize((int(cc+20),int(cc*2)),Image.ANTIALIAS)
    # print(bg.size)

    # bg dimensions
    bw , bh = bg.size
    # opening the the_face
    face = Image.open( the_face).convert("RGBA")
    face = face.resize((int(ff),int(ff*1.7)),Image.ANTIALIAS)
    # print(face.size)
    # print(face.filename)
    # face dimensions
    fw , fh = face.size

    # opening the_cloth image
    cloth = Image.open( the_cloth).convert("RGBA")
    # r = 600.0 / cloth.shape[1]
    # dim = (600, int(cloth.shape[0] * r))
    # perform the actual resizing of the image and show it
    cloth = cloth.resize((int(cc),int(cc*1.3)),Image.ANTIALIAS)
    # cloth dimensions
    cw , ch = cloth.size
    # print(cloth.size)

    #fixing the co-ordinates for pasting
    fx = int(bw/2 - fw/2)
    cx = int(bw/2 - cw/2)

    bg.paste(face, (fx,0), mask = face)
    bg.paste(cloth, (int(cx),int(fh-ff*.29)), mask = cloth)

    # Displaying the image
    # bg.show()
    # Saving the image
    # bg = bg.convert('RGBA').save("./result/vtrvk.jpg")
    r_store = f"./result/{ getImageName( the_face)}.png"
    bg = bg.save(r_store)
    return r_store
def getImageName(file_location):
    filename = file_location.split('/')[-1]
    location = file_location.split('/')[0:-1]
    filename = filename.split('.')
    # print(filename[0])
    return filename[0]
    # filename[0] += "_resized"
    # filename = '.'.join(filename)
    # new_path = '/'.join(location) + '/' + filename


# path1 = "./images"
# path1 = "./img"
# path2 = "./output"
# listing = os.listdir(path1)
# img = "/undefined-1625031518381.jpeg"
# img = "/vk.jpg"
# print(f"output: {ExtractFace(path1+img, 'M')}")
# res = 
# print(res)
# sys.stdout.flush()

# res =  merge_face_and_background(the_cloth=the_cloth,the_face=path1+img)
'''
async def main():
    res = await merge_face_and_background(the_cloth=the_cloth,the_face=path1+img)
    print(f"res: {res}")
    return res

if __name__ == "__main__":
    random.seed(444)
    # main()
    r = asyncio.run(main())
    # r = main()
    # print()
    # print(f"res: {r}")
# path1 = "./img"
# img = "/b5.jpeg"

# grab_face = ExtractFace(sys.argv[2],'M')
# print(grab_face)
# vtr = VTR(sys.argv[1],grab_face)
# vtr = VTR(the_cloth,ExtractFace(path1+img, 'M'))
# vtr.getImageName(the_face)
# print(vtr.getImageName(the_face))
# print(f"output: {ExtractFace(path1+img, 'M')}")

# python merge_final.py ./cloths/DM333.png ./pictures/undefined-1625031518381.jpeg


'''