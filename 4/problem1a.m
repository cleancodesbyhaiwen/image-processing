clc;
clear;

mu1 = 0;
mu2 = 3;
pi1 = 0.3;
pi2 = 0.7;
sigma = 0.25;

x = -1:0.001:4;
y1 = (pi1./(sigma*sqrt(2*pi)))*exp(-(x-mu1).^2./(2*sigma.^2));
y2 = (pi2./(sigma*sqrt(2*pi)))*exp(-(x-mu2).^2./(2*sigma.^2));
y3 = y1 + y2;

%plot(x,y3);

points = zeros(10000,2);
% select a point within x range (-1,4) and y range (0,1.2)
% If the point is under the pdf curve then keep it
% until we get 10000 such points
i = 1;
while 1
    x_rand = unifrnd(-1,4);
    y_rand = unifrnd(0,1.2);
    y = (pi1./(sigma*sqrt(2*pi)))*exp(-(x_rand-mu1).^2./(2*sigma.^2))...
    + (pi2./(sigma*sqrt(2*pi)))*exp(-(x_rand-mu2).^2./(2*sigma.^2));
    if y_rand > y
        
    else
        points(i,1) = x_rand;
        points(i,2) = y_rand;
        i = i + 1;
    end 
    if i == 10000
        break
    end
end

h1 = histogram(points(:,1));
h1.Normalization = 'probability';
h1.BinWidth = 0.05;

% initialization of mu and pi by eyeballing
mu = [1.5, 4];
pi = [0.5, 1];

N = 10000;

% estimation of pi1
gamma1 = 0;
for i=1:N
    xn = points(i,1);
    gamma1 = gamma1 + (pi(1)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(1)).^2./(2*sigma.^2)) ...
    ./((pi(1)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(1)).^2./(2*sigma.^2)))+(pi(2)* ...
    (1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(2)).^2./(2*sigma.^2)))));
end
pi1_est = gamma1 / N;

% estimation of pi2
gamma2 = 0;
for i=1:N
    xn = points(i,1);
    gamma2 = gamma2 + pi(2)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(2)).^2./(2*sigma.^2))./ ...
    ((pi(1)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(2)).^2./(2*sigma.^2)))+(pi(2)* ...
    (1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(2)).^2./(2*sigma.^2))));
end
pi2_est = gamma2 / N;

% estimation of mu1 
gamma1_xn = 0;
for i=1:N
    xn = points(i,1);
    gamma1_xn = gamma1_xn + (pi(1)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(1)).^2./(2*sigma.^2)) ...
    ./((pi(1)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(1)).^2./(2*sigma.^2)))+(pi(2)* ...
    (1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(2)).^2./(2*sigma.^2)))))*xn;
end
mu1_est = gamma1_xn/gamma1;


% estimation of mu2
gamma2_xn = 0;
for i=1:N
    xn = points(i,1);
    gamma2_xn = gamma2_xn + pi(2)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(2)).^2./(2*sigma.^2))./ ...
    ((pi(1)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(2)).^2./(2*sigma.^2)))+(pi(2)* ...
    (1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(2)).^2./(2*sigma.^2))))*xn;
end
mu2_est = gamma2_xn/gamma2;






















