x = 400:10:700; %wavelength (nm)
y = 0:100:10000; %illuminance (lux)
[X,Y] = meshgrid(x,y);

F = ((Y/683)./(((4.135*3*10.^-7)./(X*10.^-9))*1.6*10.^-19))./30*10.^-12;
surf(X,Y,F)
colorbar