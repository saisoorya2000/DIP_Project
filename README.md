# Project Id 25: Face Illumination Transfer through Edge-preserving Filters

Conference: CVPR, 2011
Research Paper Link: http://jinxin.me/downloads/papers/003-CVPR2011/CVPR2011-CameryReady.pdf

## Project description

This project proposes a novel image-based method to 
transfer illumination from a reference face image to a target face image through edge-preserving filters.
According to their method, only a single reference image, without
any knowledge of the 3D geometry of the target face, is needed. 
Relit result on numerous target and reference face images with different lighting effects and genders are ran in this code.

## How To Run the Code


## Project features

* Decoupling the image into lightness and color, **[HSV colormap](https://in.mathworks.com/help/matlab/ref/rgb2hsv.html)** is used.
* WLS Filter with Adaptive Parameter, for decomposing lightness layer into large-scale and detail layer.
* Guided filter to smooth a single image with the guidance of another image ,assumption that the output image is a linear transform of the guidance image in local windows.
* There are 3 target and 4 reference testing images located in the **[data](https://github.com/saisoorya2000/DIP_Project/tree/master/data)** folder.
* The resulting images are located in the **[result](https://github.com/drakeguan/cp11fall_project1/tree/develop/result/)** folder.
* For each combination of one target image and one reference image, the resulting images are named as:
    * **target image**\_**reference name**\_**ours**\.**png**
    * Filters/main functions used: *[wls_filter.m](https://github.com/saisoorya2000/DIP_Project/blob/master/wls_filter.m)*,*[guided_filter.m](https://github.com/saisoorya2000/DIP_Project/blob/master/guided_filter.m)*,*[morphing.m](https://github.com/saisoorya2000/DIP_Project/blob/master/morphing.m)

The whole testing process is in **[demo.m](https://github.com/saisoorya2000/DIP_Project/blob/master/demo.m)**. Just take a look at it and tweak it as you wish.

## Input Images

Those input/testing images are gathered from research paper mentioned.

### Target-images
![](https://github.com/saisoorya2000/DIP_Project/blob/master/results/Storage%20Data/targets.jpg)
### Reference Images
![](https://github.com/saisoorya2000/DIP_Project/blob/master/results/Storage%20Data/references.jpg)

## Illumination Transfer & Edge Preserving Results (Some)

### ss1-ref1
![](https://github.com/saisoorya2000/DIP_Project/blob/master/results/Storage%20Data/ss1_ref1.jpg)
