r = 512; 
t = 0:0.001:0.6;
x = sin(2 * pi * 50 * t) + sin(2 * pi * 120 * t);
y = x + 2 * randn(size(t));
plot(y(1:50)), grid
 
 
Y = fft(y, r);
Pyy = Y.*conj(Y)/r;
f = 1000 * (0:r/2-1)/r;
figure(2), plot(f, Pyy(1:r/2)), grid
title(r);

r = 1024;
Y = fft(y, r);
Pyy = Y.*conj(Y)/r;
f = 1000 * (0:r/2-1)/r;
figure(3), plot(f, Pyy(1:r/2)), grid
title(r);

% r = 2048;
% Y = fft(y, r);
% Pyy = Y.*conj(Y)/r;
% f = 1000 * (0:r/2-1)/r;
% figure(4), plot(f, Pyy(1:r/2)), grid
% title(r);