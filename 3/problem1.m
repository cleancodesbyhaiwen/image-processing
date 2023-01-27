

x = imread("LENNA.jpg");
[col,row] = size(x);
x = reshape(x, [col*row, 1]);
x = rescale(x);  % This is the column stack of the original image


alpha = 10000;
dark_current = 2.8;
read_noise = 5.5;
y = poissrnd((alpha*x + dark_current)) + normrnd(0, sqrt(read_noise)); % This is the column stack version of the converted imaged prior to ADC()
ADC = 2^10; % 10 bit ADC register, thus range is 0-1024
y = reshape(y, [col,row])/alpha; % converting back to matrix 
y = round(y * ADC); % mapping y to [0, 2^ADC]
y = y / ADC; % mapping back to [0,1]


imshow(y);

% Calculating the sum of diffrences of pixel value to the orignal image
y_column = reshape(y, [col*row, 1]);
diff = 0;
for i = 1:260610
    diff = diff + (y_column(i)-x(i)).^2;
end 

