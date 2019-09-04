function newSpeeds = nextIterationSpeeds(swarmSpeeds,swarmPositions,globalBest,localBests,Pl,Pg,k)
Ph=Pl+Pg;
rl = repmat(rand(size(swarmSpeeds,1),1),1,size(swarmSpeeds,2));
rg = repmat(rand(size(swarmSpeeds,1),1),1,size(swarmSpeeds,2));
globalBestmat = repmat(globalBest,size(swarmSpeeds,1),1);
Xhi=(2*k)/(abs(2-Ph-sqrt(Ph^2-4*Ph)));
newSpeeds = Xhi.*(swarmSpeeds +...
            Pl.*rl.*(localBests - swarmPositions) +...
            Pg.*rg.*(globalBestmat - swarmPositions));

end

