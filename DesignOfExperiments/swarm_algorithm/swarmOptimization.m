function globalBest = swarmOptimization(varargin)
tic                   

if nargin == 9
    funScore = varargin{1};
    Pi = varargin{2};
    numParams = varargin{3};
    swarmSize = varargin{4};
    eps = varargin{5};
    stickLim = varargin{6};
    Pl = varargin{7};
    Pg = varargin{8};
    k = varargin{9};
    anim2d = varargin{10};
elseif nargin == 5 
    funScore = varargin{1};
    Pi = varargin{2};
    numParams = varargin{3};
    numJoints = varargin{4};
    gifName = varargin{5};
    swarmSize=500;
    eps=-1E10;        
    stickLim = 20;
    Pl=1;
    Pg=5;
    k=0.2;
    anim2d = 1;
end

lb = zeros(1,numParams);
ub = 2*pi*ones(1,numParams);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



[swarm, globalBest, localBests, scores, bestScore] = initPositions(funScore,swarmSize,numParams,lb,ub,Pi);
swarmSpeeds = initSpeeds(swarmSize,numParams,lb,ub);

iteration = 0;
stick = 0;
%%%%%%%%%%%%%%%%%%%%%%ANIMATION%%%%%%%%%%%%%%%%%%%%%%%%
if anim2d
    hFig = figure;
    set(0,'units','pixels')
    ssize = get(0,'ScreenSize');
    set(hFig, 'Position', [0 0 ssize(3) ssize(4)])
    plotConfig2d(swarm,numJoints)
    kt=1;
    set(gca,'nextplot','replacechildren')
    f = getframe(hFig);
    [im,map] = rgb2ind(f.cdata,256);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while bestScore>=eps
    prBest = bestScore;
    swarm=swarm + swarmSpeeds;
    [scoresNew,bestNewScore,bestNewIndx] = calculateScores(funScore,swarm,Pi,lb,ub);
    if bestNewScore < bestScore
        bestScore  = bestNewScore;
        globalBest = swarm(bestNewIndx,:);
    end
    curBest = bestScore;
    change = find(scoresNew<scores);
    scores(change) = scoresNew(change);
    localBests(change,:) = swarm(change,:);
    
    if curBest == prBest
        stick = stick+1;
    else
        stick = 0;
    end
    
    swarmSpeeds = nextIterationSpeeds(swarmSpeeds,swarm,globalBest,localBests,Pl,Pg,k);
    averageScore = mean(scoresNew);
    printState(iteration,bestScore,averageScore,stick)
    iteration = iteration+1;
    
    if stick >= stickLim
        break;
    end
    
    if anim2d
        plotConfig2d(swarm,numJoints)
        f = getframe(hFig);
        im(:,:,1,kt) = rgb2ind(f.cdata,map);
        kt=kt+1;
    end
end

if anim2d
    imwrite(im,map,strcat(gifName,'.gif'),'DelayTime',0,'LoopCount',inf)
end

end

%function to print current state of optimization
function  printState(iteration,bestScore,averageScore,stick)
disp(strcat('iteration: ',num2str(iteration),'   best score: ',num2str(bestScore),...
                '   average score: ',num2str(averageScore),'   stick: ',num2str(stick)));
end

function  plotConfig2d(matrix,numJoints)
combos = nchoosek(1:numJoints,2);
m = size(combos,1);

w = floor(sqrt(m));
h = ceil(m/w);

for i = 1:size(combos,1)
    subplot(w,h,i)
    plot(matrix(:,combos(i,1)),matrix(:,combos(i,2)),'*b');
    grid on
    axis square 
    xlim([0,2*pi])
    ylim([0,2*pi])
    xlabel(strcat('q',num2str(combos(i,1)),'(rad)'),'FontSize',14)
    ylabel(strcat('q',num2str(combos(i,2)),'(rad)'),'FontSize',14)
end

end

