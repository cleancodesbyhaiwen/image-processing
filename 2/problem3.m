
mean = 0.1;
x = -3:0.00001:3;
y = 1./sqrt(4.5*pi).*exp((-(x-mean).^2)./4.5);

y(x<0) = 0;
y(x>1) = 0;

fun = @(x) 1./sqrt(4.5*pi).*exp((-(x-mean).^2)./4.5);

y(x==0) = (1./sqrt(4.5*pi).*exp((-(0-mean).^2)./4.5)) + integral(fun, -Inf,0);
y(x==1) = (1./sqrt(4.5*pi).*exp((-(1-mean).^2)./4.5)) + integral(fun, 1,Inf);


plot(x,y);

