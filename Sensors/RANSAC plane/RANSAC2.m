function [New] = RANSAC2(MX)

iter=500;
maxdist=0.1;
X = MX(:,1);
X = X(X>-Inf);
Y = MX(:,2);
Y = Y(Y>-Inf);
Z = MX(:,3);
Z = Z(Z>-Inf);
[Xplane,Yplane] = meshgrid(-5:1:5,-5:1:5);
% [X,Y,Z] = createPlane(1,2,3,4,3);
Abest = 0;
Bbest = 0;
Cbest = 0;
Dbest = 0;

% bestPoints = ones(length(X))*Inf;
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
    end
end

X(bestPoints) = Inf;
Y(bestPoints) = Inf;
Z(bestPoints) = Inf;

k1 = find(X<Inf);
New = [X(k1),Y(k1),Z(k1)];
hold on
plot3(New(:,1),New(:,2),New(:,3),'.k')

Zplane = -(Abest*Xplane+Bbest*Yplane+Dbest)/Cbest;
plot3(Xplane,Yplane,Zplane,'.r');
xlim([-2 2]);
ylim([-2 2]);
zlim([0 4]);          
end

