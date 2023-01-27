theta = logspace(-3,2,1000);
Y = 1 - exp(-theta);

semilogx(theta, Y, '.');
