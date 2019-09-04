%creating of spectrum with/without noize
close all
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=3;        %number of curves
s=[2250,2350,2450,2520,2600,2680,2810,2880];
% s=[2250,2300,2450,2520,2600,2680,2810,2880];
am=zeros(1,n);
w=zeros(1,n);
witch='settled';
switch witch
    case 'settled'
%         w=[44 50];
%         am=[1.0 1.4];
        w=[55 50 68];
        am=[1.3 1.4 1.8];
    case 'similar'
%%%%%%similar%%%%%%%%%%%%%%%%%%%%%%
for i=1:n
w(i)=90;
am(i)=10;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'same amplitude'
%%%%%%same amplitude%%%%%%%%%%%%%%%
w=[30 10];
for i=1:n
am(i)=10;
w(i)=rand*100;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'same width'
%%%%%%same width%%%%%%%%%%%%%%%%%%%        
for i=1:n
w(i)=90;
am(i)=rand*1;
end

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
a=1900;  %input('a=');
b=2800;   %input('b=');
step=1; %input('step=');
X=a:step:b; 
error=0.1; %input('error=');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:n
Y(i,:)=am(i)./(1+((X-s(i)).^2)/((w(i))^2));
end
Yp=Lorentz(X,am,w,s,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ysum=sum(Y);
pogr=(rand(1,length(Y))-0.5)*2*error;  %noize
new=Ysum+Ysum.*pogr;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
writedata('datar_with_noize.txt',a,b,step,new);
writedata('datar_without_noize.txt',a,b,step,Ysum);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(1,2,1);
% h1=plot(X,new,'b');
h1=plot(X,Ysum,'b',X,Y,'r',X,Yp,'g');
grid on
xlabel('frequency');
ylabel('intensity');
% legend('Модельный контур');
% set(gca,'fontsize',15)
% subplot(1,2,2);
% h2=plot(X,Ysum,'--b',X,Y,'r');
set(h1,'Linewidth',2.5);
% set(h2,'Linewidth',2.5);
% grid on
% xlabel('frequency');
% ylabel('intensity');
% legend('Суммарный контур', 'Восстановленные контура');
% set(gca,'fontsize',15)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%