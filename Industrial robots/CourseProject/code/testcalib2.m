close all
clear all

funScore1 = @sumJacobians_7DOF;
funScore2 = @planarSumJacobians;

%Geometric parameters 
Pi2l = [0,0,1,1];
Pi3l = [0,0,0,1,1,1];
Pi4l = [0,0,0,0,1,1,1,1];
Pi7DOF = [0,0,0,0,0,0,0,0.4,0.4];

%options for optimizator
options = optimoptions('particleswarm','SwarmSize',800,'HybridFcn',@fmincon,...
    'Display','iter','UseParallel',true);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2 LINKS MANIPULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numparams2l = 10;
% optimalPlanar2DOF = swarmOptimization(funScore2,Pi2l,numparams2l,2,'planar2DOF');

lb = zeros(1,numparams2l);
ub = 2*pi*ones(1,numparams2l);
optimalPlanar2DOF = particleswarm(@(Qx) planarSumJacobians(Qx,Pi2l),numparams2l,lb,ub,options);

figure
plotAnglesCircle(optimalPlanar2DOF,2);
title('Angles distribution for optimized configuration')
print('-dpng','-r300','angles2l.png')
figure
planarForward(reshape(optimalPlanar2DOF,[],2),Pi2l,1);
print('-dpng','-r300','config2l.png')
%%%%%%%%% Random 2 link %%%%%%%%%%
Qrand2l = 2*pi*rand(1,numparams2l);
figure
plotAnglesCircle(Qrand2l,2);
title('Angles distribution for random configuration')
print('-dpng','-r300','random2l.png')

%%%%%%%%%% Sum of Sines & Cosines %%%%%%%%%%%%%%
disp('Optimal configuration scores:')
sco2l = calculateSinCos(optimalPlanar2DOF,2);
disp('Random configuration scores:')
scr2l = calculateSinCos(Qrand2l,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 3 LINKS MANIPULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numparams3l = 18;
% optimalPlanar3DOF = swarmOptimization(funScore2,Pi3l,numparams3l,3,'planar3DOF');
lb = zeros(1,numparams3l);
ub = 2*pi*ones(1,numparams3l);
optimalPlanar3DOF = particleswarm(@(Qx) planarSumJacobians(Qx,Pi3l),numparams3l,lb,ub,options);
figure
plotAnglesCircle(optimalPlanar3DOF,3);
title('Angles distribution for optimized configuration')
print('-dpng','-r300','angles3l.png')

figure
planarForward(reshape(optimalPlanar3DOF,[],3),Pi3l,1);
print('-dpng','-r300','config3l.png')

%%%%%%%%% Random 3 link %%%%%%%%%%
Qrand3l = 2*pi*rand(1,numparams3l);
figure
plotAnglesCircle(Qrand3l,3);
title('Angles distribution for random configuration')
print('-dpng','-r300','random3l.png')
%%%%%%%%%% Sum of Sines & Cosines %%%%%%%%%%%%%%
disp('Optimal configuration scores:')
sco3l = calculateSinCos(optimalPlanar3DOF,3);
disp('Random configuration scores:')
scr3l = calculateSinCos(Qrand3l,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 4 LINKS MANIPULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numparams4l = 28;
% optimalPlanar4DOF = swarmOptimization(funScore2,Pi4l,numparams4l,4,'planar4DOF');
lb = zeros(1,numparams4l);
ub = 2*pi*ones(1,numparams4l);
optimalPlanar4DOF = particleswarm(@(Qx) planarSumJacobians(Qx,Pi4l),numparams4l,lb,ub,options);
figure
plotAnglesCircle(optimalPlanar4DOF,4);
title('Angles distribution for optimized configuration')
print('-dpng','-r300','angles4l.png')
figure
planarForward(reshape(optimalPlanar4DOF,[],4),Pi4l,1);
print('-dpng','-r300','config4l.png')

%%%%%%%%% Random 3 link %%%%%%%%%%
Qrand4l = 2*pi*rand(1,numparams4l);
figure
plotAnglesCircle(Qrand4l,4);
title('Angles distribution for random configuration')
print('-dpng','-r300','random4l.png')

%%%%%%%%%% Sum of Sines & Cosines %%%%%%%%%%%%%%
disp('Optimal configuration scores:')
sco4l = calculateSinCos(optimalPlanar4DOF,4);
disp('Random configuration scores:')
scr4l = calculateSinCos(Qrand4l,4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%  KUKA MANIPULATOR   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numparams7Kuka = 70;
% optimal7DOF = swarmOptimization(funScore1,Pi7DOF,numparams7Kuka,7,'kuka7DOF');
lb = zeros(1,numparams7Kuka);
ub = 2*pi*ones(1,numparams7Kuka);
optimal7DOF = particleswarm(@(Qx) sumJacobians_7DOF(Qx,Pi7DOF),numparams7Kuka,lb,ub,options);

figure
plotKuka(reshape(optimal7DOF,[],7))
print('-dpng','-r300','configKuka.png')
figure
plotAnglesCircle(optimal7DOF,7);
title('Angles distribution for optimized configuration')
print('-dpng','-r300','anglesKuka.png')

Qrand7Kuka = 2*pi*rand(1,numparams7Kuka);
plotAnglesCircle(Qrand7Kuka,7);
title('Angles distribution for random configuration')
print('-dpng','-r300','randomKuka.png')

disp('Optimal configuration score:')
optimizedScore = sumJacobians_7DOF(optimal7DOF,Pi7DOF);
disp(num2str(optimizedScore))
disp('Random configuration score:')
randomScore = sumJacobians_7DOF(Qrand7Kuka,Pi7DOF);
disp(num2str(randomScore))