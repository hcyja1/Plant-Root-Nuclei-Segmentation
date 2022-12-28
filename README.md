
Confocal Laser Scanning Microscopy (CLSM) is an optical imaging technique heavily used in biological sciences which can be used to analyze samples such as the tip of a plant root. Though, quantitative cell analysis can pose to be a tedious task without automation and the accuracy levels vary within the capability of individual. Meanwhile, the efficiency and accuracy within the capability of computing in image processing can be exponential if done properly. Image processing can significantly speed up and potentially produce more accurate quantitative cell analysis results, as well as lift some load off the shoulders of tired researchers hence allowing them to focus more attention on other segments of their work.

This repo showcases the pipeline used to extract the quantitative data of a given set of confocal laser microscopic images of plant roots.

The pipeline can be simplified to 6 steps: RGB Processing, Colour Space Conversion, Pre Processing, Thresholding, Binary Image Processing and Analysis.


How to Run : 
1) Make sure the images, findNuclei.m, and runResults.m are in the same
folder.
2) Open runResults.m in matlab, and just run the code. There shuld be
several images popping up, along with the image analysis histograms.
3) If you would like to pass another image through, go to the runResults.m,
call the findNuclei.m function, and pass the image as a parameter.

First Image Example:
![StackNinja1](https://user-images.githubusercontent.com/73547478/209740568-5e1e2361-8add-412b-985f-078265d121f7.jpg)
![ws1](https://user-images.githubusercontent.com/73547478/209740593-557f154c-44fe-4c6d-983c-2766f38c2fae.png)
![RGB1](https://user-images.githubusercontent.com/73547478/209740607-e88e403e-608b-49dc-9484-bbc67ede334a.png)

Second Image Example:
![StackNinja2](https://user-images.githubusercontent.com/73547478/209740617-7b29d6c6-1dab-4b78-bc29-86f0b45208e4.jpg)
![RGB2](https://user-images.githubusercontent.com/73547478/209740623-47cc537f-2955-4539-95e6-9aad50a74bfc.png)
![WS2](https://user-images.githubusercontent.com/73547478/209740625-f64eb9b6-74a9-4b68-83e0-5b777b1710e1.png)

Third Image Example:
![StackNinja3](https://user-images.githubusercontent.com/73547478/209740632-7d9274f8-0b57-40aa-8198-815fe8de7478.jpg)
![RGB3](https://user-images.githubusercontent.com/73547478/209740638-e4044afa-ff1a-4589-a1bc-f414f19d6e79.png)
![WS3](https://user-images.githubusercontent.com/73547478/209740641-672761b1-eeba-4566-81fe-2336afd246d3.png)

Analysis Example :
![brightnessanalysis](https://user-images.githubusercontent.com/73547478/209740750-557f9345-d45f-4ac2-bc17-e4de70da8706.png)
![shapeanalysis1](https://user-images.githubusercontent.com/73547478/209740751-768d7137-6934-4b7c-89b8-f660c35ae0fb.png)
![sizeanalysis1](https://user-images.githubusercontent.com/73547478/209740756-4a87e468-616e-4623-8643-19842b91163f.png)


Full written report : https://drive.google.com/file/d/1FsseBH1GoJCJ0yOqRaVpSu7CVwgz8qFB/view?usp=sharing
