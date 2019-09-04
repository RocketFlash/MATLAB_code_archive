a=1801;
b=2800;  
step=1;
param=1;
X=a:step:b;
s=[2200 2250 2350];
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
err=0.05;
ncurve([2200 2250 2350],noize{1},err);
[X,Yexp,s]=readdata('datar_with_fnoize.txt',2);
right=[0.7 2 0.5 77 35 80];
num=length(s);
Matrx=[0.001977006	2.450346757	0.233982985	41287.09159	59.96964742	27.03323568];
a1=Matrx(1:num);
w1=Matrx(num+1:end);
a2=right(1:num);
w2=right(num+1:end);
Y=Lorentz(X,a2,w2,s,param);
Yd=zeros(num,length(X));
Yr=zeros(num,length(X));
for i=1:num
Yd(i,:)=a1(i)./(1+((X-s(i)).^2)/(w1(i))^2);
end
for i=1:num
Yr(i,:)=a2(i)./(1+((X-s(i)).^2)/(w2(i))^2);
end
hold on
h1=plot(X,Yexp,'-.b');
set(h1,'Linewidth',2);
h2=plot(X,Y,'--k');
set(h2,'Linewidth',2);
h3=plot(X,Yd,'r');
set(h3,'Linewidth',2);
h4=plot(X,Yr,'-.g');
set(h4,'Linewidth',2);
hold off
legend([h1 h2 h3(1) h4(1)],'Сигнал с шумом','Суммарный восстановленный','Элементарные составляющие','Истинные значения',-3);
xlabel('Волновое число/см^{-1}','FontSize', 12);
ylabel('Интенсивность','FontSize', 12);
set(gca,'ylim',[-0.1 3]);
grid on