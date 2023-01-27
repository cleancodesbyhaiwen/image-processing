x = 0:0.1:1; %size (micrometer)
y = 0:100:10000; %illuminance (lux)
[X,Y] = meshgrid(x,y);

F = ((Y/683)./(((4.135*3*10.^-7)./(550.*10.^-9))*1.6*10.^-19))./30.*X.^2*10.^-12;
surf(X,Y,F)
colorbar