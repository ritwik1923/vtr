import sys
# sys.path.insert(0, "./vtr/")
import merge_final as vtr
the_cloth = "./cloths/DM333.png"
path1 = "./images"
# path1 = "./img"
path2 = "./output"
# listing = os.listdir(path1)
# img = "/undefined-1625031518381.jpeg"
img = "/vk.jpg"
def vtr():
    print(vtr.merge_face_and_background(the_cloth,path1+img))
