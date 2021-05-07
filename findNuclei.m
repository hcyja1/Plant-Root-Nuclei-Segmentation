
function [F] = findNuclei(bio_image)
image = imread(bio_image);
figure,imshow(image);
title('Original Image');
%--------------------RGB Processing ---------------------%
%Apply Gamma correction to linear RGB Values
%Retain quality whilst brightening image

%------Alternatives------%
% Alternative 1 : Histogram Equalisation , but too bright.
%gammaCorrection = histeq(image);

% Alternative 2 : Linear RGB, Too dark.
%gammaCorrection = rgb2lin(image);
%figure,imshow(gammaCorrection);
%-------------------------%

gammaCorrection = lin2rgb(image,'ColorSpace','adobe-rgb-1998');
figure,imshow(gammaCorrection);
title('Gamma Correction');
%----------------- Colour space conversion ------------%

%-------Alternatives-------%
%Alternative 1 : LAB Channel
%lab = rgb2lab(gammaCorrection);
%im_a = lab(:,:,2);
%figure,imshow(im_a ,[-127 -1]);

%Alternative 2 : RGB Channel
%figure,imshow(gammaCorrection(:,:,2));
%-------------------------%

%RGB To HSV Conversion 
im_hsv = rgb2hsv(gammaCorrection);

%Seperate the channels and clean up the hue
im_hIn = im_hsv(:,:,1);
im_s = im_hsv(:,:,2);
im_v = im_hsv(:,:,3);
im_h = immultiply(im_hIn,1.3);

%-------------------Pre-Processing-------------------%

%------Alternatives for Noise Reduction--------%
%Alternative 1 : Mean Filter
%radius = 5;
%filter = ones(radius,radius)/(radius*radius);
%fspecial = imfilter(im_h,filter);
%fspecial = adapthisteq(fspecial);
%figure,imshow(fspecial);
%title('Mean Filter Noise Removal');

%Alternative 2 : Gaussian Filter
%h = fspecial('gaussian',5,5);
%test = imfilter(im_h,h);
%test = adapthisteq(test);
%figure,imshow(test);
%title('Gaussian Filter Noise Removal');

%Alternative 3 : Anistropic Diffusion
%AnsD = imdiffusefilt(im_h);
%AnsD = adapthisteq(AnsD);
%figure,imshow(AnsD);
%title('Anistropic Diffusion Noise Removal');

%Noise Reduction through Median Filter
result{1} = im_h;
     for K = 2 : 5
       result{K} = medfilt2(result{K-1});
     end
im_h = result{4};

%Histogram Equalisation for Contrast 
im_h = adapthisteq(im_h);

%------Alternatives for Sharpening--------%
%Alternative 1 : Canny Edge
%CE = edge(im_h,'canny');
%ceNew = im_h+CE;
%ceDone = imgaussfilt(ceNew);
%figure,imshow(ceDone);
%title('Canny Edge Sharpening');

%Alternative 2 : Sobel Edge
%SE = edge(im_h,'sobel');
%seNew = im_h+SE;
%seDone = imgaussfilt(seNew);
%figure,imshow(seDone);
%title('Sobel Edge Sharpening');

%Sharpen
laplacianKernel = [-1,-1,-1;-1,8,-1;-1,-1,-1];
laplacianImage = imfilter(im_h, laplacianKernel);
im_sharpened = im_h + laplacianImage;

%Smoothing
K = imgaussfilt(im_sharpened);

%Morphological
se = strel('disk',10);
im_h = imsubtract(imadd(K,imtophat(K,se)),imbothat(K,se));
im_h = imadjust(im_h);
%figure,imshow(im_h);
%title('Pre Processing Completed');

%-----------------Otsu Thresholding-----------------%
%------Alternatives for Thresholding--------%
%alt_threshold = imbinarize(im_h,'adaptive');
%figure,imshow(alt_threshold);
%title('Alternative Thresholding');

level = graythresh(im_h);
im_h = imbinarize(im_h,level);
figure,imshow(im_h);
title("Thresholded");

%-----------------Binary Image Processing-----------%
%Speckle Removal
CC = bwconncomp(im_h,8);
S = regionprops(CC,'Area');
L = labelmatrix(CC);
finalResult = ismember(L,find([S.Area] >= 55));
%figure,imshow(finalResult);
%title("Area Size Limitation");

%Morph transformation
se = strel('disk',2);
finalResult = imopen(finalResult,se);
finalResult = medfilt2(finalResult);
%figure,imshow(finalResult);
%title("Morph Transform and Speckle Removed");

%Water-Shedding
D = -bwdist(~finalResult);
%-------RGB View-----------%
%D(~finalResult) = -Inf;
%RGBWShed = watershed(D);
%figure,imshow(label2rgb(RGBWShed,'jet','w'));
%title('RGB Watershedding');
%--------------------------%
mask = imextendedmin(D,2);
D2 = imimposemin(D,mask);
wShedNuclei = watershed(D2);
wShedBW = finalResult;
wShedBW(wShedNuclei == 0) = 0;
medfilt2(wShedBW);
figure,imshow(wShedBW);
title('Final and Watershedded Result');
%-------------------Image Overlay------------------%

%Original Hue Channel Overlay
green_nuclei = im_hIn>=0.15 & im_hIn<=0.3;
im_s = im_s.*green_nuclei;
im_hsv(:,:,2) = im_s;
seg_rgb = hsv2rgb(im_hsv);
figure,imshow(seg_rgb);
title('Original Hue Channel Overlay');

perimeter = bwperim(wShedBW);
overlay = imoverlay(gammaCorrection, perimeter, [.3 1 .3]);
overlay2 = imfuse(gammaCorrection,wShedBW,'blend');
figure,imshow(overlay2);
title('Blended Overlay');
figure,imshow(overlay);
title('Nuclei Circled Overlay');

%-----------------------Image Analysis-------------------------%
%Calculating Nuclei
cc = bwconncomp(wShedBW,8);
cc.NumObjects

%Pixel size analysis
rprops = regionprops(wShedBW,'Area');
area = [rprops.Area];
figure,histfit(area,20,'normal');
title('Size Analysis');

%Brightness Analysis
brightnessProps= regionprops(cc,im_v,'MeanIntensity');
brightnessHistogram = cell2mat(struct2cell(brightnessProps));
figure,histfit(brightnessHistogram,20,'normal');
title('Brightness Analysis');

%Shape Analysis
shapeProps = regionprops(cc,'Eccentricity');
eccentricityHistogram = cell2mat(struct2cell(shapeProps));
figure,histfit(eccentricityHistogram,20,'normal');
title('Shape Analysis');

end