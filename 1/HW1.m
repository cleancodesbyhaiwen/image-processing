close all;
clear all;
clc;
% Loading the image and displaying the image
%Image source: https://en.wikipedia.org/wiki/Lenna#/media/File:Lenna_(test_image).png

Lenna = imread('Lenna.png');
figure;
subplot(3,3,1),imshow(Lenna);
title("Original Image");

%Diaplying top 200x200 sub-region
subplot(3,3,2),imshow(Lenna(1:200,1:200,1:3));
title('Top 200x200 sub region');

%Seperating into green, red, blue
red = Lenna(:,:,1);
green = Lenna(:,:,2);
blue = Lenna(:,:,3);

a = zeros(size(Lenna, 1), size(Lenna, 2));
just_red = cat(3, red, a, a);
just_green = cat(3, a, green, a);
just_blue = cat(3, a, a, blue);

subplot(3,3,3),imshow(just_red);
title("Red Image");
subplot(3,3,4),imshow(just_green);
title("green Image");
subplot(3,3,5),imshow(just_blue);
title("Blue Image");
imwrite(just_red, "red.jpg");
imwrite(just_green, "green.jpg");
imwrite(just_blue, "blue.jpg");

%2x Downsample image
[r,c,p] = size(Lenna);
downLenna = imresize(Lenna, 2, 'bicubic');
subplot(3,3,6),imshow(downLenna);
title("2x downsampled image");
