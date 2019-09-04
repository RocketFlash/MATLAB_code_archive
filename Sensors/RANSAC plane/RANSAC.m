function [A,B,C,D] = RANSAC()
iter=500;
maxdist=2;
[X,Y,Z] = createPlane(1,2,3,4,3);
Abest = 0;
Bbest = 0;
Cbest = 0;
Dbest = 0;
[Xplane,Yplane] = meshgrid(-50:2:150,-50:2:150);
t=1;
plot3(X,Y,Z,'.b');
legend('Points from LIDAR','RANSAC','Corresponding points');
vv=[60 20];
view(vv);
grid on;
xlim([-100 200]);
ylim([-100 200]);
zlim([-200 200]);
f=getframe;
[im,map] = rgb2ind(f.cdata,256);
im(1,1,1,1) = 0;
im(:,:,1,1) = rgb2ind(f.cdata,map);

bestPoints = ones(length(X))*Inf;
maxNumberOfPoints = 0;
for i = 1:iter
    sz = size(X);
    sz = sz(1)*sz(2);
    j1 = randi([1 sz]);
    j2 = randi([1 sz]);
    j3 = randi([1 sz]);
    [A,B,C,D] = PlaneModelParameters(X(j1),Y(j1),Z(j1),X(j2),Y(j2),Z(j2),X(j3),Y(j3),Z(j3));
    cur = ones(1,sz)*Inf;
    num = 0;
    
    for j = 1:length(X)
        d=Distance(X(j),Y(j),Z(j),A,B,C,D);
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
            Dbest = D;
            bestPoints = cur(cur~=Inf);
            Zplane = -(A*Xplane+B*Yplane+D)/C;
            hPlot = plot3(X,Y,Z,'*b',Xplane,Yplane,Zplane,'.r',X(bestPoints),Y(bestPoints),Z(bestPoints),'.b');
            view(vv);
            legend('Points from LIDAR','RANSAC','Corresponding points');
            grid on;
            xlim([-100 200]);
            ylim([-100 200]);
            zlim([-200 200]);
            f=getframe;
            im(:,:,1,t) = rgb2ind(f.cdata,map);
            t=t+1;
    end
end

imwrite(im,map,'ransac.gif','DelayTime',0.5,'LoopCount',inf)
end

