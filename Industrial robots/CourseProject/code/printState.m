%function to print current state of optimization
function  printState(iteration,bestScore,averageScore,stick)
disp(strcat('iteration: ',num2str(iteration),'   best score: ',num2str(bestScore),...
                '   average score: ',num2str(averageScore),'   stick: ',num2str(stick)));
end

