
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

Full written report : https://drive.google.com/file/d/1FsseBH1GoJCJ0yOqRaVpSu7CVwgz8qFB/view?usp=sharing
