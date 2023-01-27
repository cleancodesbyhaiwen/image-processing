clc;
clear;

img = rgb2gray(im2double(imread('phantom.png')));
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

lambda = 0.01;
rho = 1;

img_f = fft2(img); % This Fx
y = S.*img_f; % This is SFx

y_real = real(img_f); % This is real part of Fx
y_imag = imag(img_f); % This is imaginary part of Fx

% The following is interpolation on Fx given only the pixels on (ix, iy)
% This part is the interpolation on real part 
samples_imag = zeros(1,cols*rows*0.5);
for i=1:20000
    samples_imag(i) = y_imag(iy(i),ix(i));
end
nx_imag = cols;
ny_imag = rows;
[X_imag,Y_imag] = meshgrid([1:1:nx_imag],[1:1:ny_imag]);
v_imag = griddata(iy,ix,samples_imag,Y_imag,X_imag);
v_imag(isnan(v_imag)) = 0.5;
% This is the interpolation on imaginary part
samples_real = zeros(1,cols*rows*0.5);
for i=1:20000
    samples_real(i) = y_real(iy(i),ix(i));
end
nx_real = cols;
ny_real = rows;
[X_real,Y_real] = meshgrid([1:1:nx_real],[1:1:ny_real]);
v_real = griddata(iy,ix,samples_real,Y_real,X_real);
v_real(isnan(v_real)) = 0.5;
% We get the final interpolation by combining real part and imaginary part
v = complex(v_real, v_imag);



FtSy = S.*ifft2(y);
eigDtD = abs(fft2([1,-1],rows,cols)).^2 + abs(fft2([1 -1]',rows,cols)).^2;
eigAtA = S + rho*eigDtD;
eigAtA(eigAtA==0) = rho;

x = zeros(row,cols);
u1 = zeros(rows,cols);
u2 = zeros(rows,cols);

x_expec = ifft2(v);
[Dx_expec1, Dx_expec2] = ForwardD(x_expec);
v1 = max(abs(Dx_expec1+u1)-lambda/rho, 0) .* sign(Dx_expec1+u1);
v2 = max(abs(Dx_expec2+u2)-lambda/rho, 0) .* sign(Dx_expec2+u2);

for i = 1:10
    rhs = y + rho*fft2(Dive(v1-u1,v2-u2),rows,cols);
    x = real(ifft2( rhs./ eigAtA));
    [Dx1, Dx2] = ForwardD(x);
    v1 = max(abs(Dx1+u1)-lambda/rho, 0) .* sign(Dx1+u1);
    v2 = max(abs(Dx2+u2)-lambda/rho, 0) .* sign(Dx2+u2);
    u1 = u1 + (Dx1 - v1);
    u2 = u2 + (Dx2 - v2);
    %subplot(3,8,i);
    imshow(x,[]);
    title(sprintf('iter = %3g', i));
    pause(0.5);
end