clear all
close all
X = [-5,-10,10,10];
Y = [-5,5,10,-15];
teta = pi/2;
R = [cos(teta), sin(teta);-sin(teta),cos(teta)];
W = [7,0;0,7];
T=W*R;
A = [X;Y]';
newMatrix = (A * T)';
X1 = newMatrix(1,:);
Y1 = newMatrix(2,:);
hold on
grid on
xlim([-120,120]);
ylim([-120,120]);
patch(X1,Y1,'red');
patch(X,Y,'blue');