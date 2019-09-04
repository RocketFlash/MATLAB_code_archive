function [theta1,theta2] = INVERSE (C1)

L0=300;
L1=300;
L2=100;

A1 = [0,0];
A2 = [L0,0];
% A1 is the origin, A1-A2 goes in the X direction

d1 = sqrt((A1(1)-C1(1))^2 + (A1(2)-C1(2))^2);
%distance from A1 to C
d2 = sqrt((A2(1)-C1(1))^2 + (A2(2)-C1(2))^2);
%distance from A2 to C

phi1 = acos (L1^2+d1^2-L2^2)/(2*d1*L1);
theta1 = phi1+atan2(C1(2)-A1(2),C1(1)-A1(1));
phi2 = acos (L1^2+d2^2-L2^2)/(2*d2*L1);
theta2 = -phi2+atan2(C1(2)-A2(2),C1(1)-A2(1));

coef = 180/pi;
theta1 = coef * theta1;
theta2 = coef * theta2;

end