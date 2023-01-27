clc;
clear;

imagefiles = dir('PSFs/*.png');      
nfiles = length(imagefiles); 
A = zeros(16384,1000); % This is the matrix storing column stacks of all 1000 PSFs

for i=1:nfiles % Store column stacks of all 1000 PSFs in A
    currentfilename = imagefiles(i).name;
    currentimage = imread(append('PSFs/', currentfilename));    
    [col,row] = size(currentimage);
    currentimage = reshape(currentimage, [col*row, 1]);
    currentimage = rescale(currentimage);  % This is the column stack of the original image
    for j=1:16384
        A(j,i) = currentimage(j);
    end
end

[U,S,V] = svd(A); % Appplying singular value decoposition on A

phi = zeros(16384,32); % This is the matrix of leading 32 basis functions
for i=1:32
    for j = 1:16384
        phi(j,i) = U(j,i);
    end
    currentimage = U(:,i);
    currentimage = reshape(currentimage, [128,128]);
    currentimage = rescale(currentimage); 
    %subplot(4,8,i), imshow(currentimage,[])
end

% reading the PSF0020 into a column stack
PSF0020filename = imagefiles(20).name;
PSF0020 = double(imread(append('PSFs/', PSF0020filename)));
PSF0020 = reshape(PSF0020, [16384, 1]);
PSF0020 = rescale(PSF0020); 
% reading the PSF0040 into a column stack
PSF0040filename = imagefiles(40).name;
PSF0040 = double(imread(append('PSFs/', PSF0040filename)));
PSF0040 = reshape(PSF0040, [16384, 1]);
PSF0040 = rescale(PSF0040); 
% reading the PSF0064 into a column stack
PSF0064filename = imagefiles(64).name;
PSF0064 = double(imread(append('PSFs/', PSF0064filename)));
PSF0064 = reshape(PSF0064, [16384, 1]);
PSF0064 = rescale(PSF0064); 
% reading the PSF0083 into a column stack
PSF0083filename = imagefiles(83).name;
PSF0083 = double(imread(append('PSFs/', PSF0083filename)));
PSF0083 = reshape(PSF0083, [16384, 1]);
PSF0083 = rescale(PSF0083); 

alpha20 = transpose(U) * PSF0020; % coefficients alpha for reconstructing PSF0020
alpha40 = transpose(U) * PSF0040; % coefficients alpha for reconstructing PSF0040
alpha64 = transpose(U) * PSF0064; % coefficients alpha for reconstructing PSF0064
alpha83 = transpose(U) * PSF0083; % coefficients alpha for reconstructing PSF0083

% Reconstructing PSF0020 by summing up the multiplication of 32 basis
% function and the corresponsind coefficients 
PSF20_recons = zeros(16384,1);
for i=1:32
    PSF20_recons = PSF20_recons + alpha20(i) * phi(:,i);
end 
PSF20_recons = reshape(PSF20_recons, [128, 128]);
PSF20_recons = rescale(PSF20_recons); 
subplot(2,2,1),imshow(PSF20_recons,[])
% Reconstructing PSF0040 by summing up the multiplication of 32 basis
% function and the corresponsind coefficients 
PSF40_recons = zeros(16384,1);
for i=1:32
    PSF40_recons = PSF40_recons + alpha40(i) * phi(:,i);
end 
PSF40_recons = reshape(PSF40_recons, [128, 128]);
PSF40_recons = rescale(PSF40_recons); 
subplot(2,2,2),imshow(PSF40_recons,[])
% Reconstructing PSF0064 by summing up the multiplication of 32 basis
% function and the corresponsind coefficients 
PSF64_recons = zeros(16384,1);
for i=1:32
    PSF64_recons = PSF64_recons + alpha64(i) * phi(:,i);
end 
PSF64_recons = reshape(PSF64_recons, [128, 128]);
PSF64_recons = rescale(PSF64_recons); 
subplot(2,2,3),imshow(PSF64_recons,[])
% Reconstructing PSF0080 by summing up the multiplication of 32 basis
% function and the corresponsind coefficients 
PSF83_recons = zeros(16384,1);
for i=1:32
    PSF83_recons = PSF83_recons + alpha83(i) * phi(:,i);
end 
PSF83_recons = reshape(PSF83_recons, [128, 128]);
PSF83_recons = rescale(PSF83_recons); 
subplot(2,2,4),imshow(PSF83_recons,[])










