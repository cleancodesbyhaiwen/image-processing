clc;
clear;

imagefiles = dir('PSFs/*.png');      


currentfilename = imagefiles(1).name;
currentimage = imread(append('PSFs/', currentfilename));    
[col,row] = size(currentimage);
currentimage = reshape(currentimage, [col*row, 1]);
%currentimage = rescale(currentimage);  % This is the column stack of the original image

PSF0020filename = imagefiles(20).name;
PSF0020 = imread(append('PSFs/', PSF0020filename));
subplot(2,2,1),imshow(PSF0020)

PSF0040filename = imagefiles(40).name;
PSF0040 = imread(append('PSFs/', PSF0040filename));
subplot(2,2,2),imshow(PSF0040);

PSF0064filename = imagefiles(64).name;
PSF0064 = imread(append('PSFs/', PSF0064filename));
subplot(2,2,3),imshow(PSF0064)

PSF0083filename = imagefiles(83).name;
PSF0083 = imread(append('PSFs/', PSF0083filename));
subplot(2,2,4),imshow(PSF0083)