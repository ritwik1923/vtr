from PIL import Image 
import numpy as np

img = Image.open("faces/vk1_face.jpg")

background = Image.open("bg.jpg")

background.paste(img,(0,0),img)

background.save('Merge resutls/vkfinal.jpg',"JPG")