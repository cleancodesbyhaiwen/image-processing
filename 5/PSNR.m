clc;
clear;

img = rgb2gray(im2double(imread('phantom.png')));
[rows,cols] = size(img);

PSNR_mean = zeros(1,10);
for k=1:10
    percent = 0.1*k;
    P_SNR = zeros(1,100);
    
    for j=1:100
        nsamples = uint16(round(rows*cols*percent));
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
        
        y = S.*fft2(img);
        FtSy = S.*ifft2(y);
        eigDtD = abs(fft2([1,-1],rows,cols)).^2 + abs(fft2([1 -1]',rows,cols)).^2;
        eigAtA = S + rho*eigDtD;
        eigAtA(eigAtA==0) = rho;
        
        x = zeros(row,cols);
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
        end
        P_SNR(j) = -10*log10(mean((img(:)-x(:)).^2));
    end
    PSNR_mean(k) = mean(P_SNR);
end

plot([10:10:100], PSNR_mean);