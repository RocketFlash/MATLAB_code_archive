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

%SOLUTION USING LAPLACE
syms s t x Y
f = t^2+2*t;
tspan = [1,2];
y0 = [-1/6,-3/4];
F = laplace(f,t,s);
Y1 = (s*Y - y0(1));
Y2 = (s^2*Y - s*y0(1)-y0(2));
Sol = solve(Y2 - 2*Y1 - F, Y);
sol = ilaplace(Sol,s,t);
sol = subs(sol,t,x-1);
simplify(sol)
h = ezplot(sol,tspan);
set(h, 'Color', 'green','LineStyle','--')
legend('numeric solution','symbolic solution','laplace');
xlabel('t','FontSize',16,'FontWeight','bold');
ylabel('y(t)','FontSize',16,'FontWeight','bold');
grid on

