clc;
clear;

mu1 = 0.0006;
mu2 = 3;
pi1 = 0.3009;
pi2 = 0.6991;
sigma = 0.25;

x = -1:0.001:4;
y1 = (pi1./(sigma*sqrt(2*pi)))*exp(-(x-mu1).^2./(2*sigma.^2));
y2 = (pi2./(sigma*sqrt(2*pi)))*exp(-(x-mu2).^2./(2*sigma.^2));
y3 = y1 + y2;

plot(x,y3);