clear all

FS = 333; % sampling rate of 333 Hz
N = FS/2;

A = importdata('open1');
d = A.data;

% port = serial('/dev/tty.keyserial1');
% fopen(port);
% PortData = fread(port,'precision');

b  = butter(4, [6 20]/(N), 'bandpass');
data=filter(b,1,d);

r = 512;
figure(1)
grid;

f = FS * (0:r/2-1)/r; 
t=1;
Z(1:length(data)-r-1000)=0;
for i=1000:(length(data)-r)
    Y = fft(data(i:i+511),r);    
    Pyy = Y.*conj(Y)/r;
    qq = mean(Pyy(9:15));
    plot(f(10:30), Pyy(10:30)-qq);
    Z(i-999) = sum(Pyy(10:25)-qq);
    xlim([3 14]);
    ylim([0 1E-10]);
    xlabel('frequency (Hz)')
    ylabel('amplitude')
    grid on
    pause(4);
end              
mean(Z)

B = importdata('rauvclose.log');
data = B.data;

Y = fft(data,r);
Pyy = Y.*conj(Y)/r;
f = FS * (0:r/2-1)/r;
figure(2), plot(f(3:20), Pyy(3:20)), grid
              