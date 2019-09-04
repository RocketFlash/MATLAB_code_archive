close all

tic

%Configurations for Kuka iiwa robot
Q = zeros(16,7);

%Geometric parameters 
Pi = [0,0,0,0,0,0,0,0.4,0.4];

%lower and upper bounds for optimizator
lb = zeros(1,length(Q(:)));
ub = 2*pi*ones(1,length(Q(:)));

%options for optimizator
options = optimoptions('particleswarm','SwarmSize',500,'HybridFcn',...
    @fmincon,'Display','iter','UseParallel',true);

%optimizator returns a vector, so we should convert it to matrix
[A,fval,fl] = particleswarm(@(Qx) sumJacobians_7DOF(Qx,Pi),length(Q(:)),lb,ub,options);
Qn = reshape(A,[],7);

[x,fval,fl] = ga(@(Qx) sumJacobians_7DOF(Qx,Pi),length(Q(:)),lb,ub,options);
figure(4)
plotKuka(Qn);
Tnew = sumJacobians_7DOF(A,Pi);
toc