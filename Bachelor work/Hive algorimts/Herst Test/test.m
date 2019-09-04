clear all
ncurve([2200 2250 2350],'noize\FN_1000_H09_3_NORM.mat',0.1);
[X,Yexp,s]=readdata('datar_with_fnoize.txt',2);
right=[0.7 77 2 35 0.5 80];
thebest=[0.235831526	2.345883727	-0.119184802	268.5717129	59.29112076	7162.692943];
thebest=thebest(:,[1 4 2 5 3 6]);
Y=Lorentz(X,thebest,s,0);
% Yrig=Lorentz(X,right,s,0);
num=length(s);
Yd=zeros(num,length(X));
for i=1:num 
    Yd(i,:)=Lorentz(X,thebest((2*i-1):(2*i)),s(i),0);
end
for i=1:num 
    Yr(i,:)=Lorentz(X,right((2*i-1):(2*i)),s(i),0);
end
hold on
h1=plot(X,Yexp,'-.b');
h2=plot(X,sum(Yr),'--k');
h3=plot(X,Yd,'r');
h4=plot(X,Yr,'-.g');
hold off
set(h1,'Linewidth',2);
set(h2,'Linewidth',2);
set(h3,'Linewidth',2);
set(h4,'Linewidth',2);
legend([h1 h2 h3(1) h4(1)],'Сигнал с шумом 10%','Суммарный восстановленный АРЧ','Элементарные составляющие с помощью АРЧ','Истинные значения');
% legend([h1 h2 h3(1) h4(1)],'Сигнал с шумом 10%','Суммарный восстановленный МНК','Элементарные составляющие с помощью МНК','Истинные значения');
% legend([h1 h2 h3(1) h4(1)],'Сигнал c шумом 10%','Суммарный восстановленный АПК','Элементарные составляющие с помощью АПК','Истинные значения');