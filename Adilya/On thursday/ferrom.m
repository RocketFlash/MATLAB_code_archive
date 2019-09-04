Tc = 700;
A = 0.067;

Z1 = 1:30000;
Z = Z1/1000;
T = 1./Z .* (Tc*tanh(Z) - A);
Y = tanh(Z);

plot(T,Y)