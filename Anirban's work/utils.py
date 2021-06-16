import cv2
import numpy as np

def find_largest_contour(image):
    """
    This function finds all the contours in an image and return the largest
    contour area.
    :param image: a binary image
    """
    image = image.astype(np.uint8)
    contours, hierarchy = cv2.findContours(
        image,
        cv2.RETR_TREE,
        cv2.CHAIN_APPROX_SIMPLE
    )
    largest_contour = max(contours, key=cv2.contourArea)
    return largest_contour

def show(name, image):
    """
    A simple function to visualize OpenCV images on screen.
    :param name: a string signifying the imshow() window name
    :param image: NumPy image to show
    """
    cv2.imshow(name, image)
    cv2.waitKey(0)

def apply_new_background(mask3d, foreground, z, save_name):
        """
        This function applies a new background to the extracted foreground image
        if `--new-background` flag is `True` while executing the file.
        :param mask3d: mask3d mask containing the foreground binary pixels
        :param foreground: mask containg the extracted foreground image
        :param save_name: name of the input image file
        """
        # normalization of mask3d mask, keeping values between 0 and 1
        mask3d = mask3d / 255.0
        # get the scaled product by multiplying
        foreground = cv2.multiply(mask3d, foreground)
        # read the new background image
        background = cv2.imread('bg.jpg')
        # resize it according to the foreground image
        background = cv2.resize(background, (foreground.shape[1], foreground.shape[0]))
        background = background.astype(np.float)
        # get the scaled product by multiplying
        background = cv2.multiply(1.0 - mask3d, background)
        # add the foreground and new background image
        new_image = cv2.add(foreground, background)
        new_image = new_image.astype(np.uint8)
        # show('New image', new_image)
        face = new_image[z[2]:z[3],z[0]:z[1]]
        # show('Face',face)
        cv2.imwrite(f"{save_name}_face.jpg", face)
