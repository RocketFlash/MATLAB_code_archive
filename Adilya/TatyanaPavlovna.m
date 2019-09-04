Tc = 300;
A = 0.067;

Z = 1:15000;
T = 1./Z .* (Tc*tanh(Z) - A);
Y = tanh(Z);

plot(T,Y)


A = load('3_FC1KOE.dat');
Texp = A(:,1);
ChiExperiment = A(:,2);

% 
% [q,i] = max(ChiExperiment);
% 
% Texp = Texp(i:end);
% ChiExperiment = ChiExperiment(i:end);


k0 = [1,1,1];

fun = @(k) (k(1) + k(2)./(Texp-k(3))) - ChiExperiment;

OptParam = lsqnonlin(fun,k0);

t = linspace(Texp(1),Texp(end));
ChiTeor = OptParam(1) + OptParam(2)./(t-OptParam(3));
plot(Texp,ChiExperiment,'.r',t,ChiTeor,'b');

Chi0 = strcat('Chi0=',num2str(OptParam(1)));
C = strcat('C=',num2str(OptParam(2)));
teta = strcat('teta=',num2str(OptParam(3)));
disp(strcat(Chi0,',',C,',',teta));

grid on

