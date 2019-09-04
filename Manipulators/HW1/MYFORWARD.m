function [C1,C2] = MYFORWARD(theta1,theta2)

L0 = 300;
L1 = 300;
L2 = 100;

A1 = [0 0];
A2 = [L0 0];

coef = pi/180;
theta1 = coef*theta1;
theta2 = pi - coef*theta2;

xB1 = A1(1)+L1*cos(theta1);
yB1 = A1(2)+L1*sin(theta1);
xB2 = A2(1)+L1*cos(theta2);
yB2 = A2(2)+L1*sin(theta2);

d = sqrt((xB2-xB1)^2+(yB2-yB1)^2);
tt = atan2(abs(xB2-xB1),abs(yB2-yB1));
phi = acos(d/(2*L2));
C1 = [xB1+L2*cos(tt+phi),yB1+L2*sin(tt+phi),(180/pi)*(tt+phi)];
C2 = [xB1+L2*cos(phi-tt),yB1+L2*sin(phi-tt),(180/pi)*(phi-tt)];
end

