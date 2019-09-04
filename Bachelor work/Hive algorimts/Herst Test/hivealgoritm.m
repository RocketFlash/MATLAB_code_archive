clear all
close all
tic                             %time control
figure(2);
param=2;                   %number of parameters                    
eps=0;                     %maximum error
error=0.1;
lib(10,1)=struct('matrx',0);
noize={%'noize\FN_1000_H01_3_NORM.mat',...
       %'noize\FN_1000_H02_3_NORM.mat',...
       %'noize\FN_1000_H03_3_NORM.mat',...
       %'noize\FN_1000_H04_3_NORM.mat',...
       %'noize\FN_1000_H05_3_NORM.mat'%,...
       %'noize\FN_1000_H06_3_NORM.mat',...
       %'noize\FN_1000_H07_3_NORM.mat',...
       %'noize\FN_1000_H08_3_NORM.mat',...
       'noize\FN_1000_H09_3_NORM.mat'...
};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
err=0.05;
% right=[0.7 77 2 35];
% for nz=1:length(err)
% ncurve([2200 2250 2350],noize{1},err(nz));
% ncurve([2200 2350],noize{1},err);
% [X,Yexp,s]=readdata('datar_without_noize.txt',2);
A=importdata('spec.asc');
A=A';
X=A(1,13618:13834);
Yexp=A(2,13618:13834);
Yexp=Yexp';
if Yexp(1)>Yexp(end)
Yexp=Yexp-Yexp(end);
else
Yexp=Yexp-Yexp(1);
end
y1=Yexp(1);
y2=Yexp(end);
x1=X(1);
x2=X(end);
Yline=((y2-y1)*((X-x1)/(x2-x1))-y1);
Yexp=Yexp-Yline';

% Matrix=zeros(10,num*param);
s=[553.73 561.8 582.1];
num=length(s);
% A=importdata('spec.asc');
% A=A';
% X=A(1,13618:13834);
% Yexp=A(2,13618:13834);
% Yexp=Yexp';
% if Yexp(1)>Yexp(end)
% Yexp=Yexp-Yexp(end);
% else
% Yexp=Yexp-Yexp(1);
% end
% y1=Yexp(1);
% y2=Yexp(end);
% x1=X(1);
% x2=X(end);
% Yline=((y2-y1)*((X-x1)/(x2-x1))-y1);
% Yexp=Yexp-Yline';
% 
[wmax,amax]=wamaxsearch(X,Yexp);
% % [pks locs]=findpeaks(diff(Yexp,1));
% % 
% % num = size(pks,1);                          %number of curves
% % s=zeros(1,num); 
% % for i=1:num
% %     s(i)=X(locs(i));
% % end
Yexp=Yexp';
% s=[554.5 582];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=1000;
Pp=2.1;
Pg=2.2;
Ph=Pp+Pg;
k=0.9;
p=1;
Xhi=(2*k)/(abs(2-Ph-sqrt(Ph^2-4*Ph)));
% for t1=1:10
hive=hiveinit(N,num,param,s,amax,wmax);
speed=zeros(size(hive));
speed=speed(:,1:end-1);
for i=1:size(hive,1)
    Y=Lorentz(X,hive(i,:),s,param);
    S=SQ(Yexp,Y);
    hive(i,end)=S;
end
hivebest=hive;
x=find(hive(:,end) == min(hive(:,end)));
thebest=hive(x,:);
l=2;
start=1;
stop =1;
m=1;
iter=1;
% outfile = 'out2.gif';
while thebest(1,end)>=eps
    start=thebest(1,end);
    if start==stop
        m=m+1;
    else m=1;
    end
    if m>100
        break
    end
    for i=1:N
        for j=1:num*param
            speed(i,j)=Xhi*(speed(i,j)+Pp*rand*(hivebest(i,j)-hive(i,j))+Pg*rand*(thebest(j)-hive(i,j)));
        end
    end
    for i=1:N
        for j=1:num*param
            hive(i,j)=hive(i,j)+speed(i,j);
        end
    end
    for i=1:size(hive,1)
        Y=Lorentz(X,hive(i,:),s,param);
        S=SQ(Yexp,Y);
        hive(i,end)=S;
        if hive(i,end)<hivebest(i,end)
            hivebest(i,:)=hive(i,:);
        end
    end
    
    thebest=sortrows(hivebest,size(hivebest,2));
    thebest=thebest(1,:);
    
    stop=thebest(1,end);
    hq=plot(hive(:,1),hive(:,2),'.r');
% set(hq,'Linewidth',2)
% axis( [ 0, 1.2*amax, 0, 1.2*wmax ] )
% f = getframe;
% im=frame2im(f);
% [imind,cm] = rgb2ind(im,256);
%     if iter == 1
%         imwrite(imind,cm,outfile,'gif','DelayTime',0.25,'LoopCount',inf);
%     else
%         imwrite(imind,cm,outfile,'gif','DelayTime',0.25,'WriteMode','append');
%     end
%  iter=iter+1;
err(p)=thebest(1,end);;
p=p+1;
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matrix(t1,1:num)=thebest(1:2:end-1);
% Matrix(t1,num+1:end)=thebest(2:2:end-1);
% end
% lib(nz).matrx=Matrix;
% end
% str1={'H'};
% str2={':M'};
% writexls('newton.xlsx',lib,str1,str2);
% 
Yd=zeros(num,length(X));
% Yr=zeros(num,length(X));
for i=1:num 
    Yd(i,:)=Lorentz(X,thebest((2*i-1):(2*i)),s(i),0);
end
% for i=1:num 
%     Yr(i,:)=Lorentz(X,right((2*i-1):(2*i)),s(i),0);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(1,2,1);
fig1=figure(1);
% subplot(1,2,1);
hold on
h1=plot(X,Yexp,'--k');
h2=plot(X,sum(Yd),'-.b');
h3=plot(X,Yd,'r');
% h4=plot(X,Yr,'--g');
hold off
xlabel('Волновое число/см^{-1}','fontsize',14);
ylabel('Интенсивность','fontsize',14);
grid on
% subplot(1,2,2);
set(h1,'Linewidth',2);
set(h2,'Linewidth',2);
set(h3,'Linewidth',2);
% set(h4,'Linewidth',2);
figure(2)
h5=plot(0:p-2,err);
xlabel('Количество итераций','fontsize',14);
ylabel('Ошибка','fontsize',14);
set( h5, 'LineWidth', 2 );
grid on
legend([h1 h2 h3(1)],'Экспериментальные данные','Суммарный восстановленный АПК','Элементарные составляющие с помощью АПК');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc