clc;
clear;



img = double(imread("portrait.jpg"))/255;

w = 5;
sigma = [20, 0.1];


bflt_img1 = bfilter2(img,w,sigma);
imshow(img);