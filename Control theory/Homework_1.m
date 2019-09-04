% NUMERIC SOLUTION
% initial parameters
y0 = [-1/6,-3/4];
% calculation interval
tspan = [1,2];
% function
f = @(t,y) [y(2); 2*y(2)+t^2-1];
% ode solver
[t,y] = ode45(f,tspan,y0);
plot(t,y(:,1),'ob')
hold on

%SYMBOLIC SOLUTION
syms y(x)
Dy = diff(y);
y(x) = dsolve(diff(y, 2) - 2*Dy - x^2 + 1 == 0,y(1)==-1/6,Dy(1)==-3/4)
fplot(y,[1,2],'r')
legend('numeric solution','symbolic solution');