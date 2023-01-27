clc;
clear;


rows= 256;
cols = 256;
S      = load('quiz5_S.txt');

lambda = 0.01;
rho = 1;

y_real = load('quiz5_y_real.txt');
y_imag = load('quiz5_y_imag.txt');
y      = y_real + 1i*y_imag;


y = S.*y;
FtSy = S.*ifft2(y);
eigDtD = abs(fft2([1,-1],rows,cols)).^2 + abs(fft2([1 -1]',rows,cols)).^2;
eigAtA = S + rho*eigDtD;
eigAtA(eigAtA==0) = rho;

x = zeros(rows,cols);
v1 = zeros(rows,cols);
v2 = zeros(rows,cols);
u1 = zeros(rows,cols);
u2 = zeros(rows,cols);

for i = 1:20
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