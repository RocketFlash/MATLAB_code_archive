function Kalman()
load('case4.mat');
Z = Acc1(:,2)';
T = Acc1(:,1)';
Xsimple = zeros(1,length(Z));
X = zeros(1,length(Z));
K = zeros(1,length(Z));
eOpt = zeros(1,length(Z));
Xsimple(1) = Z(1);
X(1) = Z(1);
Ksimple=0.165;
K(1) = 0.6;
sigmaKsi=5;
sigmaEta=14;

eOpt(1)=sigmaEta;
for i = 1:length(Z)-1
    eOpt(i+1)=sqrt((sigmaEta^2)*(eOpt(i)^2+sigmaKsi^2)/(sigmaEta^2+eOpt(i)^2+sigmaKsi^2));
    K(i+1)=(eOpt(i+1))^2/sigmaEta^2;
    Xsimple(i+1) = Ksimple*Z(i+1)+(1-Ksimple)*Xsimple(i);
    X(i+1) = K(i+1)*Z(i+1)+(1-K(i+1))*X(i);
end

subplot(2, 1, 1);
h1 = plot(T,Z,'.g',T,Xsimple,'b',T,X,'--r');
legend('experimental data','simple kalman filter','kalman filter');
grid on
subplot(2, 1, 2)
h2 = plot(T,K,T,Ksimple*ones(1,length(T)));
legend('variable K','constant K');
set(h1,'LineWidth',3);
set(h2,'LineWidth',3);
grid on 
end
