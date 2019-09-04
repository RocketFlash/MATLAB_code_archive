ncurve([2200 2250 2350]);
[X,Yexp,s]=readdata('datar_with_fnoize.txt',2);
right=[0.7 77 2 35 0.5 80];
thebest=[0.684937099	1.989452267	0.501603849	76.98728652	35.73563187	82.29481883];
thebest=thebest(:,[1 4 2 5 3 6]);
Y=Lorentz(X,thebest,s,0);
% Yrig=Lorentz(X,right,s,0);
Yd=zeros(num,length(X));
for i=1:num 
    Yd(i,:)=Lorentz(X,thebest((2*i-1):(2*i)),s(i),0);
end
for i=1:num 
    Yr(i,:)=Lorentz(X,right((2*i-1):(2*i)),s(i),0);
end
hold on
h1=plot(X,Yexp,'-.b');
h2=plot(X,Y,'--k');
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