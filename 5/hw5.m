clc;
clear;

img = rgb2gray(imread('phantom.png'));
%imshow(img);

F=fft2(img); %send image to fourier space
imshow(F);
log_img=log(1+F); %comvert to log scale
%imshow(log_img,[]);
%constructing S matrix
[rows,cols] = size(img);
nsamples = uint16(round(rows*cols*0.5));
ix = randi(cols, nsamples, 1);
iy = randi(rows, nsamples, 1);
S = zeros(rows, cols);
for i=1:nsamples
    row = ix(i);
    col = iy(i);
    S(row,col) = 1;
end
y = S.*log_img; %convolve with image
%imshow(y,[]);

rho = 1;
lambda = 0.01;

y = F;
FtSy= ifft2(y);
eigDtD = abs(fftn([[1,-1]], [cols,rows])).^2 + abs(fftn([[1],[-1]], [cols,rows])).^2;
eigAtA = S + rho*eigDtD;
eigAtA(eigAtA==0) = rho;

x = zeros(rows,cols);
v1 = zeros(rows,cols);
v2 = zeros(rows,cols);
u1 = zeros(rows,cols);
u2 = zeros(rows,cols);


