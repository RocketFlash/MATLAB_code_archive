function y=CHI(x)

A1=load('3.FC1KOE.dat');
T1=A1(:,1);
Chi1=A1(:,2);

A = 0.067;

Z1 = 1:0.1:30000;
Z = Z1/1000;
T = 1./Z .* (x(1)*tanh(Z) - A);
Y = tanh(Z);

T1indexes = zeros(1,length(T1));

for i = 1:length(T1)
    [~, ind] = min(abs(T-T1(i)));
    T1indexes(i) = ind;
end

Tnew = T(T1indexes);
Znew = Z(T1indexes);
Ynew = tanh(Znew);
S=x(2)*Ynew+x(3)./(Tnew-x(4));

y=sum(abs(S'-Chi1));

plot(T1,Chi1,'.g',Tnew,S,'.r');