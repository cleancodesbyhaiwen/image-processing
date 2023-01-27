

x = im2double(imread("monalisa.png"));

%x = rgb2gray(x);

y = x(:);

L = length(y);

for i = 3:65536 % checking every pixel starting from the third one 
    if (y(i) <= y(1) + 0.035) && (y(i) >= y(1) - 0.035) % if the pixel is within the range of 0.035 relative to the first pixel
        if (y(i-1) > y(1) + 0.1) || (y(i-1) < y(1) - 0.1) % and the pixel prior to it is out of the range 0.1 to the first pixel
            break % then this pixel is assume to be the beginning of the second column
        end
    end
end

height = i - 1;
width = L / height;

figure; imshow(reshape(y, [height, width]));