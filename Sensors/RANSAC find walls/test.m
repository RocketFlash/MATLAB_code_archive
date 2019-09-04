x1=1;
x2=3;
y1=1;
y2=3;
[A,B,C]=LinearModelParameters(x1,y1,x2,y2);
X=0:0.1:100;
Y=(A.*X+C)/B;
plot(X,Y,'r',x1,y1,'*b',x2,y2,'*b');