function [C1,C2] = FORWARD (theta1,theta2)

coef = pi/180;
theta1 = coef * theta1;
theta2 = coef * theta2;
L0=300;
L1=300;
L2=100;

A1 = [0,0];
A2 = [L0,0];
% A1 is the origin, A1-A2 goes in the X direction

B1 = [A1(1) + L1*cos(theta1),A1(2)+L1*sin(theta1)];
B2 = [A2(1) + L1*cos(theta2),A2(2)+L1*sin(theta2)];
d = sqrt((B2(1)-B1(1))^2 + (B2(2)-B1(2))^2);
phi = acos((d^2)/(2*L2*d));
alpha = atan2(B2(1)-B1(1),B2(2)-B1(2));
C1 = [B1(1)+cos(alpha+phi)*L2,B1(2)+sin(alpha+phi)*L2,alpha+phi];
C2 = [B1(1)+cos(alpha-phi)*L2,B1(2)+sin(alpha-phi)*L2,alpha-phi];
% orientation is the angle between line B1-C and X axis
end