function ncurve

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=1801;
b=2800;  
step=1;
X=a:step:b;  
s=[1900 2200 2500 2650];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num=length(s);   
am=zeros(1,num);
w=zeros(1,num);
witch='settled';
switch witch
    case 'settled'
        w=[77 35 80 40 53];
        am=[0.7 2 0.5 1 1.5];
    case 'similar'
%%%%%%similar%%%%%%%%%%%%%%%%%%%%%%
for i=1:num
w(i)=90;
am(i)=10;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'same amplitude'
%%%%%%same amplitude%%%%%%%%%%%%%%%
w=[30 10];
for i=1:num
am(i)=10;
w(i)=rand*100;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'same width'
%%%%%%same width%%%%%%%%%%%%%%%%%%%        
for i=1:num
w(i)=90;
am(i)=rand*1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        
    case 'random'
%%%%%%random%%%%%%%%
for i=1:num
    r1=randn;
    r2=rand;
    w(i)=r1*40;
    am(i)=r2*10;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:num
Y(i,:)=am(i)./(1+((X-s(i)).^2)/((w(i))^2));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      White noize       %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ysum=sum(Y);
pogr=rand(1,length(Ysum)).*(max(Ysum)-min(Ysum)).*randn(1,length(Ysum));  
new=Ysum+Ysum.*pogr;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
h1=plot(X,Ysum,'b',X,Y,'r');
grid on
xlabel('frequency');
ylabel('intensity');
% figure(2);
% h2=plot(X,new,'k',X,Y,'r');
% grid on
% xlabel('frequency');
% ylabel('intensity');
% figure(3);
% h3=plot(X,Yfrac,'k',X,Y,'r');
% grid on
% xlabel('frequency');
% ylabel('intensity');
% % legend('Модельный контур');
% % set(gca,'fontsize',15)
% % subplot(1,2,2);
% % h2=plot(X,Ysum,'--b',X,Y,'r');
% set(h1,'Linewidth',2.5);
% set(h2,'Linewidth',2.5);
% grid on
% xlabel('frequency');
% ylabel('intensity');
% legend('Суммарный контур', 'Восстановленные контура');
% set(gca,'fontsize',15)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end