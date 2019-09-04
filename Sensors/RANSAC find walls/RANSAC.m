%#######################
%#Yagfarov Rauf        #
%#Innopolis University #
%#######################

% RANSAC function arguments:
% iter - number of iterations 
% maxdist - maximal allowable distance from the line to the point

function [bestPoints,Abest,Bbest,Cbest] = RANSAC(iter,maxdist,numberOfWalls) 
[X,Y] = ReadData('data.mat');
X=X(X~=0);
Y=Y(Y~=0);
Abest = 0;
Bbest = 0;
Cbest = 0;
Xline = min(X):max(X);
t=1;
Xnew = X;
Ynew = Y;
plot(X,Y,'.b');
legend('Points from LIDAR','RANSAC','Corresponding points');
grid on;
xlim([-4000 4000]);
ylim([-4000 4000]);
f=getframe;
[im,map] = rgb2ind(f.cdata,256);
im(1,1,1,numberOfWalls+1) = 0;
im(:,:,1,1) = rgb2ind(f.cdata,map);
for l = 1:numberOfWalls
    bestPoints = ones(length(Xnew))*Inf;
    maxNumberOfPoints = 0;
for i = 1:iter
    j1 = randi([1 length(Xnew)]);
    j2 = randi([1 length(Xnew)]);
    [A,B,C] = LinearModelParameters(Xnew(j1),Ynew(j1),Xnew(j2),Ynew(j2));
    
    cur = ones(1,length(Xnew))*Inf;
    num = 0;
    
    for j = 1:length(Xnew)
        d=Distance(Xnew(j),Ynew(j),A,B,C);
        if d <= maxdist
            num = num + 1;
            cur(num) = j;
        end
       
    end
    
    if num > maxNumberOfPoints
            maxNumberOfPoints = num;
            Abest = A;
            Bbest = B;
            Cbest = C;
            bestPoints = cur(cur~=Inf);
            Yline = -(A*Xline+C)/B;
    end
end
hPlot = plot(Xnew,Ynew,'.b',Xline,Yline,'r',Xnew(bestPoints),Ynew(bestPoints),'*k');
set( hPlot, 'LineWidth', 3 );
legend('Points from LIDAR','RANSAC','Corresponding points');
hold on;
grid on;
xlim([-4000 4000]);
ylim([-4000 4000]);
f=getframe;
im(:,:,1,l+1) = rgb2ind(f.cdata,map);
Xnew(bestPoints)=[];
Ynew(bestPoints)=[];
end
imwrite(im,map,'ransac.gif','DelayTime',0.5,'LoopCount',inf)
end

