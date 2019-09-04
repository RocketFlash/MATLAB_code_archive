tspan = [0 10];
y0 = 0;
[t,y] = ode45(@(t,y) sin(t)-2*y, tspan, y0);
plot(t,y);