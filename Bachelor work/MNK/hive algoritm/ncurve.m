%creating of spectrum with/without noize
close all
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=5;        %number of curves
witch='similar';
switch witch
    case 'similar'
%%%%%%similar%%%%%%%%%%%%%%%%%%%%%%
w=[30 35 37 30 30];
am=[10 15 20 20 10];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'same amplitude'
%%%%%%same amplitude%%%%%%%%%%%%%%%
w=[30 10];
am=[10 10];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'same width'
%%%%%%same width%%%%%%%%%%%%%%%%%%%        
w=[30 30];
am=[10 5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        
    case 'random'
%%%%%%random%%%%%%%%
for i=1:n
    r1=randn;
    r2=rand;
    w(i)=r1*40;
    am(i)=r2*10;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=[-40,30,70,120,170];
a=-50;  %input('a=');
b=50;   %input('b=');
step=0.1; %input('step=');
X=2*pi*a:2*pi*step:2*pi*b; 
error=0.01; %input('error=');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:n
Y(i,:)=(am(i)./(1+((X-s(i)).^2)/(w(i))^2));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ysum=sum(Y);
pogr=(rand(1,length(Y))-0.5)*2*error;  %noize
new=Ysum+Ysum.*pogr;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
writedata('data_with_noize.txt',a,b,step,new);
writedata('data_without_noize.txt',a,b,step,Ysum);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,1);
h1=plot(X,Ysum,'b',X,Y,'r');
grid on
xlabel('frequency');
ylabel('intensity');
subplot(1,2,2);
h2=plot(X,new,'r');
set(h1,'Linewidth',1.5);
set(h2,'Linewidth',1);
grid on
xlabel('frequency');
ylabel('intensity');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%