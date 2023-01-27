


x = im2double(imread("LENNA.jpg"));
figure;
subplot(2,3,1);
imshow(x);
title('original image x')
grid on;

[col,row] = size(x);
x = reshape(x, [col*row, 1]);
x = rescale(x);  % This is the column stack of the original image

alpha = 100;
Y = poissrnd(alpha*x)./alpha;
Y = reshape(Y, [col,row]); % This is the image Y by adding possion noise to X

subplot(2,3,2);
imshow(Y);
title('noisy image Y')
grid on;

Z = Y; 

subplot(2,3,3);
imshow(Z);
title('noisy image Z')
grid on;

sigma = sqrt(var(Z(:)));
maxZ = max(Z(:));
minZ = min(Z(:));
Z = (Z-minZ) / (maxZ-minZ);
sigma = sigma/(maxZ-minZ);
Zhat = BM3D(Z, sigma);
Zhat = Zhat*(maxZ-minZ)+minZ; % This is by denoising Z using BM3D

subplot(2,3,4);
imshow(Zhat);
title('denoised image Zhat')
grid on;

