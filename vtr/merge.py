from PIL import Image

# Opening the primary image (used in background)
img1 = Image.open(r"./images/background.jpg").convert("RGBA")
# https://stackoverflow.com/questions/31273592/valueerror-bad-transparency-mask-when-pasting-one-image-onto-another-with-pyt
# Opening the secondary image (overlay image)
# img2 = Image.open(r"./images/rtest1.jpg").convert("RGBA")
img2 = Image.open(r"./images/kalam.jpg").convert("RGBA")

# Pasting img2 image on top of img1
# starting at coordinates (0, 0)
img1.paste(img2, (0,0), mask = img2)

# Displaying the image
img1.show()
'''
TODO: issue!

1 => not working with png
2 => scaling of image
3 => 

'''
