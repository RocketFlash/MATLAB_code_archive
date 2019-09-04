tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=10;   %input('shift=');
w=10;   %input('width=');
am=5;   %input('amplitude=');
% disp('range [a,b] and step');
a=-30;  %input('a=');
b=30;   %input('b=');
step=0.1; %input('step=');
er=0.1; %input('error=');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=2*pi*a:2*pi*step:2*pi*b;
Y=am./(1+((X-s).^2)/(w)^2);
pogr=(rand(1,length(Y))-0.5)*2*er;
new=Y+Y.*pogr;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);plot(X,Y,'--r',X,new,'.b');
legend('teoretical measurenents','experimental measurements');
xlabel('frequency');
ylabel('intensity');
grid on;
%writing in file
writedata('data1.txt',a,b,step,new);
toc