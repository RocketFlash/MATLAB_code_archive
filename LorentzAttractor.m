%Solution for the Lorenz equations in the time interval [0,100] with initial conditions [1,1,1].
clear all
clc
sigma=10;
beta=8/3;
rho=28;
f = @(t,a) [-sigma*a(1) + sigma*a(2); rho*a(1) - a(2) - a(1)*a(3); -beta*a(3) + a(1)*a(2)];
%'f' is the set of differential equations and 'a' is an array containing values of x,y, and z variables.
%'t' is the time variable
[t,a] = ode45(f,[0 100],[1 1 1]);%'ode45' uses adaptive Runge-Kutta method of 4th and 5th order to solve differential equations

fig = figure();
set(fig,'Position',[350,200,700,300]);
frame = getframe(fig);
[im,map] = rgb2ind(frame.cdata,4);
imwrite(im,map,'animation1.gif','DelayTime',0,'Loopcount',0);
plot3(a(:,1),a(:,2),a(:,3)) %'plot3' is the command to make 3D plot
hold on
view(3)
for i=1:size(a,1)
plot3(a(i,1),a(i,2),a(i,3),'*r')
frame = getframe(fig);
[im,map] = rgb2ind(frame.cdata,4);
imwrite(im,map,'animation1.gif','DelayTime',0.1,'WriteMode','Append');
end