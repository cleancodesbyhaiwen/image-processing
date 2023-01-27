clc;
clear;

mu1 = 0;
mu2 = 3;
pi1 = 0.3;
pi2 = 0.7;
sigma = 0.25;

N = 1000; % number of samples we have

x = -1:0.001:4;
y1 = (pi1./(sigma*sqrt(2*pi)))*exp(-(x-mu1).^2./(2*sigma.^2));
y2 = (pi2./(sigma*sqrt(2*pi)))*exp(-(x-mu2).^2./(2*sigma.^2));
y3 = y1 + y2;

%plot(x,y3);

points = zeros(N,2);
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
    if i == N
        break
    end
end

h1 = histogram(points(:,1));
h1.Normalization = 'probability';
h1.BinWidth = 0.05;

% initialization of mu and pi by eyeballing
mu = [0.5, 3.5];
f_pi = [0.5, 1];

number_dis = 2; % number of gaussian distribution in the mixture

sum_gamma = zeros(1,number_dis);
sum_gamma_xn = zeros(1, number_dis);
pi_est = zeros(1,number_dis);
mu_est = zeros(1,number_dis);

% iterate through every gassian distribution every estimated pi
for n=1:number_dis
    % calculate sum of gamma for every xn
    for i=1:N
        xn = points(i,1);
        % This for loop calculate the denominator for calculating gamma 
        sum_gauss = 0;
        for k=1:number_dis
            sum_gauss = sum_gauss + (f_pi(k)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(k)).^2./(2*sigma.^2)));
        end
        sum_gamma(n) = sum_gamma(n) + (f_pi(n)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(n)).^2./(2*sigma.^2))) ./ sum_gauss;
    end
    pi_est(n) = sum_gamma(n)/N;
end

% iterate through every gassian distribution every estimated mu
for n=1:number_dis
    for i=1:N
        xn = points(i,1);
        
        % This for loop calculate the denominator for calculating gamma 
        sum_gauss = 0;
        for k=1:number_dis
            sum_gauss = sum_gauss + (f_pi(k)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(k)).^2./(2*sigma.^2)));
        end
        % calculate the sum of all gamma*xn for every xn
        sum_gamma_xn(n) = sum_gamma_xn(n) + (f_pi(n)*(1./(sigma*sqrt(2*pi)))*exp(-(xn-mu(n)).^2./(2*sigma.^2)))*xn ./ sum_gauss;
    end
    mu_est(n) = sum_gamma_xn(n)/sum_gamma(n);
end 

