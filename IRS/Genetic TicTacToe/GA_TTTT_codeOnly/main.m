% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

clear;

param = params();

agents = initialSet(param.numberOfAgents,param.genomeSize);

for gener=1:param.numberOfGenerations
    
    gener
    %displays the current generation
    
    evaluations = evaluateAgents(agents,param);
    evaluations = evaluations/sum(evaluations);
    %normalization

    prob = 1 - evaluations;
    prob = prob.^param.deathFactor;
    count = 0;
    for i=1:param.numberOfAgents
        z = rand();
        if prob(i)>z
            count = count + 1;
            survivors(count,:,:) = agents(i,:,:);
        end
    end
    % kill function

    agents = nextGeneration(survivors,param);
    
    filename = strcat('survivors_',int2str(gener));
    save(filename,'survivors');
end




