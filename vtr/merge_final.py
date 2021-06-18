


# Takes the "the_face" argument which contains the location of the face
# Takes the "the_cloth" argument which contains the location of the cloth
"""
Todo:
Please check if the arguments can be passed as strings
Also check line:28 and line:34
Whether the function Image.open() is able to read the variables the_cloth and the_face
issue: 1 not saving with jpg formate

"""
from PIL import Image

the_cloth = "./cloths/3.jpg"
the_face = "./faces/vkr.png"
# the function

def merge_face_and_background(the_cloth, the_face):

    # Opening the primary image (used in background)
    bg = Image.open(r"./images/bg.jpg").convert("RGBA")
    print(bg.size)

    # bg dimensions
    bw , bh = bg.size

    # opening the the_face
    face = Image.open(the_face).convert("RGBA")
    print(face.size)
    # face dimensions
    fw , fh = face.size

    # opening the_cloth image
    cloth = Image.open(the_cloth).convert("RGBA")
    print(cloth.size)

    # cloth dimensions
    cw , ch = cloth.size

    #fixing the co-ordinates for pasting
    fx = int(bw/2 - fw/2)
    cx = int(bw/2 - cw/2)

    bg.paste(cloth, (cx,200), mask = cloth)
    bg.paste(face, (fx,50), mask = face)

    # Displaying the image
    bg.show()
    # Saving the image
    # bg = bg.convert('RGBA').save("./result/vtrvk.jpg")
    bg = bg.save("./result/vtrvk.png")

merge_face_and_background(the_cloth,the_face)