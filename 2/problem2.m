

x = imread("LENNA.jpg");

J = imnoise(x,'gaussian',0,0.01);

x = int8(x);

J = int8(J);

y = J - x;

f = y(:);

qqplot(f);

qqplot(randn(50000,1)*0.1);