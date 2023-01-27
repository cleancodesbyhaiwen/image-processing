clc;
clear;

sample = zeros(1,1000);
locations = [50,150,250,350,450,550,650,750,850,950]; % 10 locations to be assign numebrs

% assigned random numbers to the 10 locations
for i=1:10
    sample(locations(i)) = normrnd(0,0.1);
end
% assign gaussian noise to all locations
for i=1:1000
    sample(i) = sample(i) + normrnd(0, 0.05^2);
end 

lambda = 0.01; 
x=1:1000;
figure;
stem(x,sample) % plot signal with noise

% denoising using plugging into theta 
for i=1:1000
    sample(i) = max([0, abs(sample(i))-lambda])*sign(sample(i));
end 

% plot signal after denoising
figure
stem(x,sample)