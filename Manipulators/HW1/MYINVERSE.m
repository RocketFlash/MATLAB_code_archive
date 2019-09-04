function [teta1,teta2] = MYINVERSE(C1)
x = C1(1);
y = C1(2);

L0=300;
L1=300;
L2=100;

A1 = [0,0];
A2 = [L0,0];

d1 = sqrt((x - A1(1))^2 + (y-A1(2))^2);
d2 = sqrt((x - A2(1))^2 + (y-A2(2))^2);

phi1 = acos((L1^2+d1^2-L2^2)/(2*L1*d1));
phi2 = acos((L1^2+d2^2-L2^2)/(2*L1*d2));

alpha1 = atan2(x-A1(1),y-A1(2));
alpha2 = atan2(A2(1)-x,y-A2(2));

teta1 = alpha1 + phi1;
teta2 = alpha2 + phi2;

coef = 180/pi;
teta1 = coef * teta1;
teta2 = coef * teta2;
end

