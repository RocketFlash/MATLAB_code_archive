clear all
close all

% calculate optimal experiment configurations for 2-link manipulator 
calculate_2l = 1;
% calculate optimal experiment configurations for 3-link manipulator
calculate_3l = 0;
% calculate optimal experiment configurations for 4-link manipulator
calculate_4l = 0;
% calculate optimal experiment configurations for Kuka 7DOF manipulator
calculate_Km = 0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2 LINKS MANIPULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if calculate_2l
tic
%Configurations for 2-link robot
Q = [-pi/2,pi/3;
     pi/2,pi/10;
     pi/4,pi/10;
     3*pi/4,pi/10;
     -pi/2,pi/10;
     pi/2,pi/10];

%Geometric parameters 
Pi = [0,0,1,1];

%lower and upper bounds for optimizator
lb = zeros(1,length(Q(:)));
ub = 2*pi*ones(1,length(Q(:)));

%options for optimizator
options = optimoptions('particleswarm','SwarmSize',500,'HybridFcn',@fmincon,...
    'Display','iter','UseParallel',true);

%optimizator returns a vector, so we should convert it to matrix
A = particleswarm(@(Qx) planarSumJacobians(Qx,Pi),length(Q(:)),lb,ub,options);
Qn = reshape(A,[],size(Q,2));

%calculate sum of sin and cos for evaluation 
cs = sum(cos(Qn(:,2)));
ss = sum(sin(Qn(:,2)));
cossin2 = [cs ss];

%plot calculated configurations
figure(1)
planarForward(Qn,Pi,1);
Tnew = planarSumJacobians(A,Pi)
toc
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 3 LINKS MANIPULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if calculate_3l
tic
%Configurations for 2-link robot
Q = [-pi/2,pi/3,pi/4;
     pi/2,pi/10,pi/4;
     pi/4,pi/10,pi/4;
     3*pi/4,pi/10,pi/4;
     -pi/2,pi/10,pi/4;
     pi/2,pi/10,pi/4];

%Geometric parameters 
Pi = [0,0,0,1,1,1];

%lower and upper bounds for optimizator
lb = zeros(1,length(Q(:)));
ub = 2*pi*ones(1,length(Q(:)));

%options for optimizator
options = optimoptions('particleswarm','SwarmSize',500,'HybridFcn',@fmincon,...
    'Display','iter','UseParallel',true);

%optimizator returns a vector, so we should convert it to matrix
[A,fval,fl] = particleswarm(@(Qx) planarSumJacobians(Qx,Pi),length(Q(:)),lb,ub,options);
Qn = reshape(A,[],size(Q,2));

%calculate sum of sin and cos for evaluation 
cs2 = sum(cos(Qn(:,2)));
ss2 = sum(sin(Qn(:,2)));
cs3 = sum(cos(Qn(:,3)));
ss3 = sum(sin(Qn(:,3)));
cs23 = sum(cos(Qn(:,2)+Qn(:,3)));
ss23 = sum(sin(Qn(:,2)+Qn(:,3)));
cossin3 = [cs2 ss2 cs3 ss3 cs23 ss23];
%plot calculated configurations
figure(2)
planarForward(Qn,Pi,1);
Tnew = planarSumJacobians(A,Pi)
toc
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 4 LINKS MANIPULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if calculate_4l
tic
%Configurations for 2-link robot
Q = [-pi/2,pi/3,pi/4,pi/3;
     pi/2,pi/10,pi/4,pi/3;
     pi/4,pi/10,pi/4,pi/3;
     3*pi/4,pi/10,pi/4,pi/3;
     -pi/2,pi/10,pi/4,pi/3;
     pi/2,pi/10,pi/4,pi/3];

%Geometric parameters 
Pi = [0,0,0,0,1,1,1,1];

%lower and upper bounds for optimizator
lb = zeros(1,length(Q(:)));
ub = 2*pi*ones(1,length(Q(:)));

%options for optimizator
options = optimoptions('particleswarm','SwarmSize',500,'HybridFcn',@fmincon,...
    'Display','iter','UseParallel',true);

%optimizator returns a vector, so we should convert it to matrix
[A,fval,fl] = particleswarm(@(Qx) planarSumJacobians(Qx,Pi),length(Q(:)),lb,ub,options);
Qn = reshape(A,[],size(Q,2));

%calculate sum of sin and cos for evaluation 
cs2 = sum(cos(Qn(:,2)));
ss2 = sum(sin(Qn(:,2)));
cs3 = sum(cos(Qn(:,3)));
ss3 = sum(sin(Qn(:,3)));
cs4 = sum(cos(Qn(:,4)));
ss4 = sum(sin(Qn(:,4)));
cs23 = sum(cos(Qn(:,2)+Qn(:,3)));
ss23 = sum(sin(Qn(:,2)+Qn(:,3)));
cs34 = sum(cos(Qn(:,4)+Qn(:,3)));
ss34 = sum(sin(Qn(:,4)+Qn(:,3)));
cs24 = sum(cos(Qn(:,2)+Qn(:,3)+Qn(:,4)));
ss24 = sum(sin(Qn(:,2)+Qn(:,3)+Qn(:,4)));
cossin4 = [cs2,ss2,cs3,ss3,cs4,ss4,cs23,ss23,cs34,ss34,cs24,ss24]; 
%plot calculated configurations
figure(3)
planarForward(Qn,Pi,1);
Tnew = planarSumJacobians(A,Pi)
toc
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% KUKA iiwa MANIPULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if calculate_Km
tic

%Configurations for Kuka iiwa robot
Q = zeros(10,7);

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
figure(4)
plotKuka(Qn);
Tnew = sumJacobians_7DOF(A,Pi);
toc
end

% dPi0 = [pi/6,pi/3,pi/4,0.2,0.1,0];
% Pz = Pi + dPi0;
% subplot(1,2,1);
% P = planarForward(Q,Pz,zeros(1,length(Pi)),1);
% 
% cPi = planarCalibration(P,Q,Pi,100);
% %    
% subplot(1,2,2);
% planarForward(Q,cPi,zeros(1,length(Pi)),1)
% Pz
% cPi
% sum(Pz-cPi)