close all
clear all
funScore = @sumJacobians_7DOF;
time_limit = 300; %in seconds
%Geometric parameters 
Pi7DOF = [0,0,0,0,0,0,0,0.4,0.4];
% lowerBound = [-pi,-pi,-pi,-pi,-pi,-pi,-pi];
% upperBound = [pi,pi,pi,pi,pi,pi,pi];

upperBound=[170 120 170 120 170 120 175]*pi/180;
lowerBound=[-170 -120 -170 -120 -170 -120 -175]*pi/180;

numberOfConfigurations = 10;
numparams7Kuka = 7*numberOfConfigurations;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%   PARTICLE SWARM    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = optimoptions('particleswarm','SwarmSize',800,'HybridFcn',@fmincon,...
    'Display','iter','PlotFcn',@pswplotbestf,'UseParallel',true,'MaxTime',time_limit);
% % optimal7DOF = swarmOptimization(funScore,Pi7DOF,numparams7Kuka,7,'kuka7DOF');
tic
Q_particle_swarm_optimal = particleswarm(@(Qx) sumJacobians_7DOF(Qx,Pi7DOF),numparams7Kuka,lowerBound,upperBound,options);
swarm_execution_time = toc;
% figure
% plotKuka(reshape(Q_particle_swarm_optimal,[],7))
% print('-dpng','-r300','pics/particle_swarm_configKuka.png')

figure
plotAnglesCircle(Q_particle_swarm_optimal,7);
suplabel('Angles distribution for particle swarm optimized configuration','t')
print('-dpng','-r300','pics/particle_swarm_anglesKuka.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%    GENETIC ALGORITHM     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = gaoptimset('PopulationSize', 50, 'Generations', 5000,...
    'Display', 'iter','PlotFcn',{@gaplotbestf}, 'TolFun', 1e-10, 'UseParallel', true,'TimeLimit',time_limit);
tic
Q_ga_optimal = ga(@(Qx) sumJacobians_7DOF(Qx,Pi7DOF),numparams7Kuka,[],[],[],[],lowerBound,upperBound,[],options);
ga_execution_time = toc;
% figure
% plotKuka(reshape(Q_ga_optimal,[],7))
% print('-dpng','-r300','pics/ga_configKuka.png')

figure
plotAnglesCircle(Q_ga_optimal,7);
suplabel('Angles distribution for genetic algorithm optimized configuration','t')
print('-dpng','-r300','pics/ga_anglesKuka.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%    SIMULATED ANNEALING     %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options = saoptimset('HybridFcn',@fmincon,...
    'Display','iter','PlotFcn',@saplotbestf,'TolFun', 1e-10,'DisplayInterval',100, 'MaxIter', 50000,'TimeLimit',time_limit);
Q0 = RandomConfig(numberOfConfigurations,lowerBound,upperBound);
tic
Q_simulated_annealing_optimal = simulannealbnd(@(Qx) sumJacobians_7DOF(Qx,Pi7DOF),...
    Q0(:),lowerBound,upperBound,options);
annealing_execution_time=toc;
% figure
% plotKuka(reshape(Q_simulated_annealing_optimal,[],7))
% print('-dpng','-r300','pics/simulated_annealingConfigKuka.png')

figure
plotAnglesCircle(Q_simulated_annealing_optimal,7);
suplabel('Angles distribution for simulated annealing configuration','t')
print('-dpng','-r300','pics/simulated_annealingKuka.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%       GRID SEARCH       %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       RANDOM CONFIGURATIONS       %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q_rand7Kuka = randomConfigurations(lowerBound,upperBound,numberOfConfigurations);
Q_rand7Kuka = RandomConfig(numberOfConfigurations,lowerBound,upperBound);
% figure
% plotKuka(reshape(Q_rand7Kuka,[],7))
% print('-dpng','-r300','pics/randConfigKuka.png')

figure
plotAnglesCircle(Q_rand7Kuka,7);
suplabel('Angles distribution for random configuration'  ,'t');
print('-dpng','-r300','pics/randomKuka.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      Calibration      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ideal parameters / measured parameters
idealParams = [0 0 0 0 0 400 0 0 0 0 0 0 0 400 0 0 0 0 0 0 0 0 ]';
%real parameters
realParams = [0.9159 0.3269 -0.011 -0.0129 -1.9721 395.1151 -0.0300 -0.0284 -1.8499 0.3241  0.0108 -0.0082 1.3421 403.8651 -0.0256 0.0104 0.9545 1.7773  0.0109 0.0183 -0.9918 0.0040]';

%real base and tools transformation matrices
TbaseR = [1 0 0 0; 0 1 0 0; 0 0 1 340-0.7115; 0 0 0 1];
Ttool1R= Tz(90-0.3056);
Ttool2R= Rx(2*pi/3)*Tz(90-0.5056)*Rx(-2*pi/3);
Ttool3R= Rx(-2*pi/3)*Tz(90+0.8625)*Rx(2*pi/3);
%ideal base and tools transformation matrices
Tbase = [1 0 0 0; 0 1 0 0; 0 0 1 340; 0 0 0 1];
Ttool1 =Tz(90);
Ttool2 = Rx(2*pi/3)*Tz(90)*Rx(-2*pi/3);
Ttool3 = Rx(-2*pi/3)*Tz(90)*Rx(2*pi/3);
sigma = 20*1e-3;
% sigma = 0;
% Qtest = reshape(randomConfigurations(lowerBound,upperBound,100),[],7);
Qtest = RandomConfig(10000,lowerBound,upperBound);

q=reshape(Q_particle_swarm_optimal,[],7);
%generate experimental data for 30 experiments (16 configurations * 3 points)
for i=1:size(q,1)
    M1(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool1R);
    M2(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool2R);
    M3(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool3R);
end

%find tools, base and delta pi parameters
[p_swarm,tb_swarm,~,~,~]=FindAllParams(q,sigma, idealParams, Tbase,Ttool1,Ttool2,Ttool3, M1, M2, M3);


q=reshape(Q_ga_optimal,[],7);
% generate experimental data for 30 experiments (16 configurations * 3 points)
for i=1:size(q,1)
    M1(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool1R);
    M2(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool2R);
    M3(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool3R);
end

% find tools, base and delta pi parameters
[p_ga,tb_ga,~,~,~]=FindAllParams(q,sigma, idealParams, Tbase,Ttool1,Ttool2,Ttool3, M1, M2, M3);

q=reshape(Q_simulated_annealing_optimal,[],7);
% generate experimental data for 30 experiments (16 configurations * 3 points)
for i=1:size(q,1)
    M1(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool1R);
    M2(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool2R);
    M3(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool3R);
end

% find tools, base and delta pi parameters
[p_annealing,tb_annealing,~,~,~]=FindAllParams(q,sigma, idealParams, Tbase,Ttool1,Ttool2,Ttool3, M1, M2, M3);

q=reshape(Q_rand7Kuka,[],7);
% generate experimental data for 30 experiments (16 configurations * 3 points)
for i=1:size(q,1)
    M1(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool1R);
    M2(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool2R);
    M3(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool3R);
end

% find tools, base and delta pi parameters
[p_random,tb_random,~,~,~]=FindAllParams(q,sigma, idealParams, Tbase,Ttool1,Ttool2,Ttool3, M1, M2, M3);

Q_anal = optimal_conf();
q=Q_anal;
%generate experimental data for 30 experiments (16 configurations * 3 points)
for i=1:size(q,1)
    M1(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool1R);
    M2(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool2R);
    M3(:,:,i) = RobotModelFK(q(i,:),realParams,sigma,TbaseR,Ttool3R);
end

%find tools, base and delta pi parameters
[p_anal,tb_anal,~,~,~]=FindAllParams(q,sigma, idealParams, Tbase,Ttool1,Ttool2,Ttool3, M1, M2, M3);


errors_list_gt = zeros(1,size(Qtest,1));
errors_list_calibrated_swarm = zeros(1,size(Qtest,1));
errors_list_calibrated_ga = zeros(1,size(Qtest,1));
errors_list_calibrated_annealing = zeros(1,size(Qtest,1));
errors_list_calibrated_random = zeros(1,size(Qtest,1));
errors_list_calibrated_anal = zeros(1,size(Qtest,1));

for i = 1:size(Qtest,1)
T_real = RobotModelFK(Qtest(i,:),realParams,0,TbaseR,eye(4));
T_ideal = RobotModelFK(Qtest(i,:),idealParams,0,Tbase,eye(4));
T_swarm = RobotModelFK(Qtest(i,:),idealParams+p_swarm,0,tb_swarm,eye(4));
T_ga = RobotModelFK(Qtest(i,:),idealParams+p_ga,0,tb_ga,eye(4));
T_annealing = RobotModelFK(Qtest(i,:),idealParams+p_annealing,0,tb_annealing,eye(4));
T_random = RobotModelFK(Qtest(i,:),idealParams+p_random,0,tb_random,eye(4));
T_anal = RobotModelFK(Qtest(i,:),idealParams+p_anal,0,tb_anal,eye(4));
x_real = T_real(1:3,4);
x_ideal = T_ideal(1:3,4);
x_swarm = T_swarm(1:3,4);
x_ga = T_ga(1:3,4);
x_annealing = T_annealing(1:3,4);
x_random = T_random(1:3,4);
x_anal = T_anal(1:3,4);
errors_list_gt(i)=norm(x_real-x_ideal);
errors_list_calibrated_swarm(i)=norm(x_real-x_swarm);
errors_list_calibrated_ga(i)=norm(x_real-x_ga);
errors_list_calibrated_annealing(i)=norm(x_real-x_annealing);
errors_list_calibrated_anal(i)=norm(x_real-x_anal);
errors_list_calibrated_random(i)=norm(x_real-x_random);
end

mean_gt = mean(errors_list_gt);
mean_swarm = mean(errors_list_calibrated_swarm);
mean_ga = mean(errors_list_calibrated_ga);
mean_annealing = mean(errors_list_calibrated_annealing);
mean_anal = mean(errors_list_calibrated_anal);
mean_random = mean(errors_list_calibrated_random);

std_gt = std(errors_list_gt);
std_swarm = std(errors_list_calibrated_swarm);
std_ga = std(errors_list_calibrated_ga);
std_annealing = std(errors_list_calibrated_annealing);
std_anal = std(errors_list_calibrated_anal);
std_random = std(errors_list_calibrated_random);

max_gt = max(errors_list_gt);
max_swarm = max(errors_list_calibrated_swarm);
max_ga = max(errors_list_calibrated_ga);
max_annealing = max(errors_list_calibrated_annealing);
max_anal = max(errors_list_calibrated_anal);
max_random = max(errors_list_calibrated_random);


particle_swarm_score = sumJacobians_7DOF(Q_particle_swarm_optimal,Pi7DOF);
ga_score = sumJacobians_7DOF(Q_ga_optimal,Pi7DOF);
simulated_annealing_score = sumJacobians_7DOF(Q_simulated_annealing_optimal,Pi7DOF);
analScore = sumJacobians_7DOF(Q_anal,Pi7DOF);
randomScore = sumJacobians_7DOF(Q_rand7Kuka,Pi7DOF);

disp('        Execution time        ')
fprintf('swarm     execution time: %4.5f \n', swarm_execution_time)
fprintf('ga        execution time: %4.5f \n', ga_execution_time)
fprintf('annealing execution time: %4.5f \n', annealing_execution_time)
disp('             D-Score        ')
disp('Analytical configuration score:')
disp(num2str(abs(analScore)))
disp('Particle swarm configuration score:')
disp(num2str(abs(particle_swarm_score)))
disp('Genetic algorithm configuration score:')
disp(num2str(abs(ga_score)))
disp('Simulated annealing configuration score:')
disp(num2str(abs(simulated_annealing_score)))
disp('Random configuration score:')
disp(num2str(abs(randomScore)))
disp('         Results         ')
formatSpec_anal = 'analytical  mean: %4.11f std: %8.11f max: %8.11f\n';
formatSpec_gt = 'gt          mean: %4.11f std: %8.11f max: %8.11f\n';
formatSpec_swarm = 'swarm       mean  : %4.11f std: %8.11f max: %8.11f\n';
formatSpec_ga = 'ga          mean: %4.11f std: %8.11f max: %8.11f\n';
formatSpec_annealing = 'annealing   mean: %4.11f std: %8.11f max: %8.11f\n';
formatSpec_random = 'random      mean : %4.11f std: %8.11f max: %8.11f\n';
fprintf(formatSpec_anal,mean_anal,std_anal,max_anal)
fprintf(formatSpec_gt,mean_gt,std_gt,max_gt)
fprintf(formatSpec_swarm,mean_swarm,std_swarm,max_swarm)
fprintf(formatSpec_ga,mean_ga,std_ga,max_ga)
fprintf(formatSpec_annealing,mean_annealing,std_annealing,max_annealing)
fprintf(formatSpec_random,mean_random,std_random,max_random)

