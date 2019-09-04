clear all
close all
Q = [-pi/2,0,pi/2;
    ];
%      pi/2,pi/10,pi/3;
%      pi/4,pi/10,pi/3;
%      3*pi/4,pi/10,pi/3;
%      -pi/2,pi/10,pi/3;
%      pi/2,pi/10,pi/6];
 
Pi = [0,0,0,1,1,1];
dPi0 = [0,0,0,0,0,0];
Pz = Pi + dPi0;
% subplot(1,2,1);
hold on

[P,xs,ys] = planarForward(Q,Pi,zeros(1,length(Pi)));
plot(xs,ys,'r','Marker','o','LineWidth',4)

numLinks = size(Q,2);
numExp = size(Q,1);

for z = 1:numExp
        str = '';
        for k = 1:numLinks
            str = strcat(str,'Q',num2str(k),'=',num2str(rad2deg(Q(z,k))),'\n');
        end
        str = sprintf(str);
        text(P(2*z-1),P(2*z),str)
end

%E
Q = [-pi/2,0,pi/2;
    0,pi,pi/2
    -pi/2,pi/2,pi];
[P,xs,ys] = planarForward(Q,Pi,zeros(1,length(Pi)));
for j = 1:size(xs,1)
    plot(xs(j,:)+3,ys(j,:),'r','Marker','o','LineWidth',4)
end

numLinks = size(Q,2);
numExp = size(Q,1);

for z = 1:numExp
        str = '';
        for k = 1:numLinks
            str = strcat(str,'Q',num2str(k),'=',num2str(rad2deg(Q(z,k))),'\n');
        end
        str = sprintf(str);
        text(P(2*z-1)+3,P(2*z),str)
end

%Y
Pi = [0,0,0,1,1,1.5];
Q = [-pi/2,pi,pi/4;
    -pi/2,pi,-pi/4];
[P,xs,ys] = planarForward(Q,Pi,zeros(1,length(Pi)));
for j = 1:size(xs,1)
    plot(xs(j,:)+6,ys(j,:)-1,'r','Marker','o','LineWidth',4)
end

numLinks = size(Q,2);
numExp = size(Q,1);

for z = 1:numExp
        str = '';
        for k = 1:numLinks
            str = strcat(str,'Q',num2str(k),'=',num2str(rad2deg(Q(z,k))),'\n');
        end
        str = sprintf(str);
        text(P(2*z-1)+6,P(2*z)-1,str)
end

%Y
Pi = [0,0,0,0,0.5,0.7,1,0.5];
Q = [3*pi/4,-pi/4,-pi/2,-pi/4;
    -pi/4,-pi/4,-pi/2,-pi/4];
[P,xs,ys] = planarForward(Q,Pi,zeros(1,length(Pi)));
for j = 1:size(xs,1)
    plot(xs(j,:)+9,ys(j,:)-1,'r','Marker','o','LineWidth',4)
end
numLinks = size(Q,2);
numExp = size(Q,1);

for z = 1:numExp
        str = '';
        for k = 1:numLinks
            str = strcat(str,'Q',num2str(k),'=',num2str(rad2deg(Q(z,k))),'\n');
        end
        str = sprintf(str);
        text(P(2*z-1)+9,P(2*z)-1,str)
end

%A
Pi = [0,0,0,1.4,2,1.4];
Q = [-3*pi/4,3*pi/4,-pi/4,;
    -pi/4,-3*pi/4,pi/4];
[P,xs,ys] = planarForward(Q,Pi,zeros(1,length(Pi)));
for j = 1:size(xs,1)
    plot(xs(j,:)+12,ys(j,:),'r','Marker','o','LineWidth',4)
end

numLinks = size(Q,2);
numExp = size(Q,1);

for z = 1:numExp
        str = '';
        for k = 1:numLinks
            str = strcat(str,'Q',num2str(k),'=',num2str(rad2deg(Q(z,k))),'\n');
        end
        str = sprintf(str);
        text(P(2*z-1)+12,P(2*z),str)
end

%N
Pi = [0,0,1.5,2];
Q = [3*pi/4,3*pi/4;
    -pi/4,3*pi/4];
[P,xs,ys] = planarForward(Q,Pi,zeros(1,length(Pi)));
for j = 1:size(xs,1)
    plot(xs(j,:)+17,ys(j,:)-1,'r','Marker','o','LineWidth',4)
end
numLinks = size(Q,2);
numExp = size(Q,1);
for z = 1:numExp
        str = '';
        for k = 1:numLinks
            str = strcat(str,'Q',num2str(k),'=',num2str(rad2deg(Q(z,k))),'\n');
        end
        str = sprintf(str);
        text(P(2*z-1)+17,P(2*z)-1,str)
end

Pi = [0,0,0,0,0.4,0.8,0.5,1.5];
Q = [3*pi/4,pi/4,pi/4,pi/1.5;
    pi/4,-pi/4,-pi/4,-pi/1.5];
[P,xs,ys] = planarForward(Q,Pi,zeros(1,length(Pi)));
for j = 1:size(xs,1)
    plot(xs(j,:)+23,ys(j,:)-1,'r','Marker','o','LineWidth',4)
end
numLinks = size(Q,2);
numExp = size(Q,1);

for z = 1:numExp
        str = '';
        for k = 1:numLinks
            str = strcat(str,'Q',num2str(k),'=',num2str(rad2deg(Q(z,k))),'\n');
        end
        str = sprintf(str);
        text(P(2*z-1)+23,P(2*z)-1,str)
end
    
xlabel('X(m)','FontSize',18);
ylabel('Y(m)','FontSize',18);
title('Forward Kinematics visualization');
grid on

% cPi = planarCalibration(P,Q,Pi,100);
%    
% subplot(1,2,2);
% planarForward(Q,cPi,zeros(1,length(Pi)),1)
% Pz
% cPi
% sum(Pz-cPi)
%     