%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%       MNK       %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfPoints = 100;
Xexp = 12-24*rand(1,numberOfPoints);
Noize = 5-10*rand(1,numberOfPoints);
Yexp = -14*Xexp.^2+3*Xexp-5;
Yexp2=Yexp+Noize;
SumOfGeneratedNumber = sum(Yexp2);

symX2=sum(Xexp.^2);
symX3=sum(Xexp.^3);
symX4=sum(Xexp.^4);
symX = sum(Xexp);
symY = sum(Yexp2);
symXY = sum(Xexp.*Yexp2);
symX2Y = sum((Xexp.^2).*Yexp2);
n = length(Xexp);

m1=[symX2;symX3;symX4];
m2=[symX;symX2;symX3];
m3=[n;symX;symX2];
res=[symY;symXY;symX2Y];

del = det([m1,m2,m3]);
dela = det([res,m2,m3]);
delb = det([m1,res,m3]);
delc = det([m1,m2,res]);

a = dela/del;
b = delb/del;
c = delc/del;

disp(SumOfGeneratedNumber);
Xe = 12-(0:24);
Ymnk = a*Xe.^2+b*Xe+c;
plot(Xexp,Yexp2,'*r',Xe,Ymnk);
grid on
ylim([-2000,0]);
toWrite = strcat(['y', ' = ', num2str(a), ' * x^2 ', '+', num2str(b), ' * x ', num2str(c)]);
title(toWrite);

legend('Experimental measurements','Approximation');