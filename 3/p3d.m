theta =logspace(-3,2,1000);

SNR = theta./(sqrt(exp(theta).*(1-(exp(-theta)))));

Y = 20*log10(SNR);

semilogx(theta, Y, '.');
axis([1e-3 1e2 -30 0])