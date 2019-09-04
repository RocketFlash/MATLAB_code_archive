A = importdata('rauv.log');
B = importdata('rauvclose.log');
% C = importdata('rauvclosedzatylok.log');
% D = importdata('rauvopenzatylok.log');

% figure;
% plot(A.data);
% xlabel('time');
% ylabel('voltage');
% plot(B.data);
% plot(C.data);
% plot(D.data);
discr = 300;
N = discr/2;

figure;
b  = butter(4, [6 15]/(N), 'bandpass');
fltdat=filter(b,1,A.data);
xlabel('time');
ylabel('voltage');

plot(fltdat(1:300));

%filtered data
figure;
fltdat=filter(b,1,B.data);
plot(fltdat(1:300));
xlabel('time');
ylabel('voltage');

figure;
Y = fft(fltdat,discr);
Pyy = Y.*conj(Y)/discr;
f = 1000/251*(0:127);
plot(f,Pyy(1:128))

xlabel('frequency');
ylabel('voltage');
plot(abs(Y));


