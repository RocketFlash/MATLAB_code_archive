alpha = 0.1;
beta = 0.05;
gama = 0.03;
eps = 0.15;
delta = 0.2;
c2 = 0.01;
c1 = 2;

f = @(t,x) [x(1)*(alpha-beta*x(2)-gama*x(1));-x(2)*(delta-eps*x(1))];
[t,xa] = ode23(f,[0 200],[c1 c2]);

plot(t,xa(:,1))
hold on
plot(t,xa(:,2))
title('y(t)')
xlabel('t'), ylabel('y')

% plot(xa(:,1),xa(:,2));