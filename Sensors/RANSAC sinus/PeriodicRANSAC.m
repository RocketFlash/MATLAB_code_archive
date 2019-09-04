function PeriodicRANSAC()
numberOfSinuses = 3;
err = 5;
maxDist = 5;
mtd = strcat('sin',num2str(numberOfSinuses));
numberOfPoints = 50;
iterations = 100;
Xtmp = zeros(1,numberOfPoints);
Ytmp = zeros(1,numberOfPoints);
[X,Y] = createPeriodicFunction(err);
Xbest = ones(1,length(X))*Inf;
Ybest = ones(1,length(Y))*Inf;
maxNum = 0;

plot(X,Y,'.r');
legend('data','RANSAC');
grid on
f=getframe;
l=1;
[im,map] = rgb2ind(f.cdata,256);
im(:,:,1,l) = rgb2ind(f.cdata,map);

for i = 1:iterations
    for k = 1:numberOfPoints
        jk = randi([1 length(X)]);
        Xtmp(k) = X(jk);
        Ytmp(k) = Y(jk);
    end
    ft = fit(Xtmp',Ytmp',mtd);
    XX = 0:0.01:max(X);
    YY = getXY(ft,numberOfSinuses,XX);
    [XY,d,tt] = distance2curve([XX' YY'],[X' Y']);
    XY = XY(d<maxDist,:);
    num = size(XY,1);
    if num > maxNum
        maxNum = num;
        Xbest = XY(:,1);
        Ybest = XY(:,2);
        hPlot = plot(X,Y,'.r',XX,YY,'--g',Xbest(Xbest~=Inf),Ybest(Ybest~=Inf),'.k');
        legend('data','fitting','inliers');
        set( hPlot, 'LineWidth', 3 );
        text(5,25,num2str((maxNum/length(X))*100));
        grid on
        f=getframe;
        l=l+1;
        im(:,:,1,l) = rgb2ind(f.cdata,map);
    end
end
imwrite(im,map,'ransac.gif','DelayTime',1,'LoopCount',inf)

end

