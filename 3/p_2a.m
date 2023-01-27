
theta = logspace(0,3,1000); % creating the 1000 instances of theta 
vari = zeros(1,500); % creating a 500x500 matrix of all 0s

% construct images Ys = Poisson(theta), for each image calculate the
% variance
for i = 1:1000
    Y = poissrnd(theta(i),500);
    Y = sqrt(Y + (3/8)); % transform Y
    vari(i) = var(Y(:));
end

plot(theta,vari, '.'); % plot variance VS theta 
