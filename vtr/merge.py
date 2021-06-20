from PIL import Image

# Opening the primary image (used in background)
bg = Image.open(r"./images/bg.jpg").convert("RGBA")
print(bg.size)
# bg = bg.resize()
bw , bh = bg.size
# https://stackoverflow.com/questions/31273592/valueerror-bad-transparency-mask-when-pasting-one-image-onto-another-with-pyt
# Opening the secondary image (overlay image)
# face = Image.open(r"./images/rtest1.jpg").convert("RGBA")
face = Image.open(r"./faces/vkr.png").convert("RGBA")
print(face.size)

fw , fh = face.size

cloth = Image.open(r"./cloths/3.jpg").convert("RGBA")
print(cloth.size)
# cloth1 = cloth.resize((257,485))
# cloth1.save('2_r.jpg')
# cloth1 = Image.open(r"./cloths/2_r.jpg")

cw , ch = cloth.size
# Pasting face image on top of bg
# starting at coordinates (0, 0)

fx = int(bw/2 - fw/2)
cx = int(bw/2 - cw/2)

bg.paste(cloth, (cx,200), mask = cloth)
bg.paste(face, (fx,30), mask = face)

# Displaying the image
bg.show()
'''
TODO: issue!

1 => not working with png
2 => scaling of image
3 => 

'''
