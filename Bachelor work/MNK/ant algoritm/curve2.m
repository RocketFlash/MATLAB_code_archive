tic
%creating of spectrum with noize
close all
clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('enter shift,width and amplitude of 1 curve')
s1=30;   %input('shift1=');
w1=10;   %input('width1=');
am1=20;   %input('amplitude1=');
% disp('enter shift,width and amplitude of 2 curve')
s2=8;   %input('shift2=');
w2=12;   %input('width2=');
am2=30;   %input('amplitude2=');
% disp('range [a,b] and step');
a=-30;  %input('a=');
b=30;   %input('b=');
step=0.1; %input('step=');
% disp('enter an error:')
er=0.05; %input('error=');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=2*pi*a:2*pi*step:2*pi*b;          %frequency
Y1=(am1./(1+((X-s1).^2)/(w1)^2));   %first curve
Y2=(am2./(1+((X-s2).^2)/(w2)^2));   %second curve
Y=Y1+Y2;                            %both curves
pogr=(rand(1,length(Y))-0.5)*2*er;  %noize
new=Y+Y.*pogr;                      %two curves with noize
figure(1);h1=plot(X,new,'b');%X,Y1,'--r',X,Y2,'--g',X,Y,'k',);
set(h1,'Linewidth',1.5);
legend('teoretical 1st','teoretical 2nd','teoretical sum','experimental');
xlabel('frequency');
ylabel('intensity');
grid on;
%writing in file
writedata('data.txt',a,b,step,new);
toc
