syms da11 da12 dl1 da21 da22 dl2 da31 da32 dl3 da41 da42 da43 da51 da52 da53 dl4
syms d1 d2 d3 phi4 phi5
triangleRad = 0.050;
err = 0.00005;
a11 = 0;
a12 = 0;
l1 = 0;
a21 = 0;
% a22 = 0;
l2 = 0;
a31 = 0;
a32 = 0;
l3 = 0;
a41 = 0;
% a42 = 0;
a43 = 0;
a51 = 0;
a52 = 0;
a53 = 0;
l4 = 0.1;

qa11 = pi/180;
qa12 = -pi/180;
ql1 = 0.001;
qa21 = 2*pi/180;
% qa22 = -2*pi/180;
ql2 = 0.002;
qa31 = -pi/180;
qa32 = pi/180;
ql3 = 0.001;
qa41 = -pi/180;
% qa42 = 2*pi/180;
qa43 = pi/180;
qa51 = -pi/180;
qa52 = pi/180;
qa53 = -2*pi/180;
ql4 = -0.001;

%symbolic PI vector
PI = [da11 da12 dl1 da21 dl2 da31 da32 dl3 da41 da43 da51 da52 da53 dl4];
%numerical PI vector
PI0 = [a11 a12 l1 a21 l2 a31 a32 l3 a41 a43 a51 a52 a53 l4];
%Geometric errors (delta(PI))
DPI0 = [qa11 qa12 ql1 qa21 ql2 qa31 qa32 ql3 qa41 qa43 qa51 qa52 qa53 ql4];
%PI vector with geometric errors
PI1 = PI0 + DPI0;

Q =  [d1 d2 d3 phi4 phi5];
T = transf(PI,Q);
xyz = T(1:3,4);
J = jacobian(xyz,PI);
lng = [0 1];
tet = [-pi/3,pi/3];

%%%%%%%%%%%%%%%%%%Design experiment points%%%%%%%%%%%%%%%%%%%%%%%%%%
Ldesign = generateConfig(lng,tet);
numberOfExperiments = 3;
WD0 = zeros(size(Ldesign,1),numberOfExperiments,3,3);
k = size(Ldesign,1);

for i = 1:size(Ldesign,1)
    for j = 1:numberOfExperiments
        [a1,a2,a3] = getTriangle(PI0,Ldesign(i,:),triangleRad);
        WD0(i,j,:,:) = [a1(1:3) a2(1:3) a3(1:3)]';
    end
end
% save('designPI0','WD0','Ldesign');
WD0noise = normrnd(WD0,err,size(WD0));
% save('designPI50','WD0noise','Ldesign');

WD1 = zeros(size(Ldesign,1),numberOfExperiments,3,3);
for i = 1:size(Ldesign,1)
    for j = 1:numberOfExperiments
        [a1,a2,a3] = getTriangle(PI1,Ldesign(i,:),triangleRad);
        WD1(i,j,:,:) = [a1(1:3) a2(1:3) a3(1:3)]';
    end
end
% save('designDPI0','WD1','Ldesign');
WD1noise = normrnd(WD1,err,size(WD1));
% save('designDPI50','WD1noise','Ldesign');

figure;
hold on
plot3(WD1noise(:,1,1,1),WD1noise(:,1,1,2),WD1noise(:,1,1,3),'or');
plot3(WD1noise(:,1,2,1),WD1noise(:,1,2,2),WD1noise(:,1,2,3),'og');
plot3(WD1noise(:,1,3,1),WD1noise(:,1,3,2),WD1noise(:,1,3,3),'ob');
grid on
title('generated points using designed configurations')
axis(gca,'vis3d');
hold off
%%%%%%%%%%%%%%%%%%Random experiment points%%%%%%%%%%%%%%%%%%%%%%%%%%
Lrandom = generateRandomConfig(k);
numberOfExperiments = 3;
WR0 = zeros(size(Lrandom,1),numberOfExperiments,3,3);

for i = 1:size(Lrandom,1)
    for j = 1:numberOfExperiments
        [a1,a2,a3] = getTriangle(PI0,Lrandom(i,:),triangleRad);
        WR0(i,j,:,:) = [a1(1:3) a2(1:3) a3(1:3)]';
    end
end
% save('randomPI0','WR0','Lrandom');
WR0noise = normrnd(WR0,err,size(WR0));
% save('randomPI50','WR0noise','Lrandom');

WR1 = zeros(size(Lrandom,1),numberOfExperiments,3,3);
for i = 1:size(Lrandom,1)
    for j = 1:numberOfExperiments
        [a1,a2,a3] = getTriangle(PI1,Lrandom(i,:),triangleRad);
        WR1(i,j,:,:) = [a1(1:3) a2(1:3) a3(1:3)]';
    end
end
% save('randomDPI0','WR1','Lrandom');
WR1noise = normrnd(WR1,err,size(WR1));
% save('randomDPI50','WR1noise','Lrandom');
figure;
hold on
plot3(WR1noise(:,1,1,1),WR1noise(:,1,1,2),WR1noise(:,1,1,3),'or');
plot3(WR1noise(:,1,2,1),WR1noise(:,1,2,2),WR1noise(:,1,2,3),'og');
plot3(WR1noise(:,1,3,1),WR1noise(:,1,3,2),WR1noise(:,1,3,3),'ob');
grid on
title('generated points using random configurations','FontSize',16)
axis(gca,'vis3d');
hold off
%%%%%%%%%%%%%%%%         Designed experiment         %%%%%%%%%%%%%%%%%%%%%%
%Without deltaPI with noise, designed
Ja = JacobianNum(J,PI,PI0,Q,Ldesign); 
%Compute differences in position with geomeric error (experiment) & native
%model
DPcomp1 = getMiddlePoint(WD0noise) - getMiddlePoint(WD0);
DPIcomp1 = pinv(Ja)*DPcomp1;

%With deltaPI without noise, designed
% Ja = JacobianNum(J,PI,PI0,Q,Ldesign); 
%Compute differences in position with geomeric error (experiment) & native
%model
DPcomp2 = getMiddlePoint(WD1) - getMiddlePoint(WD0);
DPIcomp2 = pinv(Ja)*DPcomp2;

%With deltaPI with noise, designed
% Ja = JacobianNum(J,PI,PI0,Q,Ldesign); 
%Compute differences in position with geomeric error (experiment) & native
%model
DPcomp3 = getMiddlePoint(WD1noise) - getMiddlePoint(WD0);
DPIcomp3 = pinv(Ja)*DPcomp3;

%%%%%%%%%%%%%%%%           Random points            %%%%%%%%%%%%%%%%%%%%%%

%Without deltaPI with noise, random
Ja = JacobianNum(J,PI,PI0,Q,Lrandom); 
%Compute differences in position with geomeric error (experiment) & native
%model
DPcomp4 = getMiddlePoint(WR0noise) - getMiddlePoint(WR0);
DPIcomp4 = pinv(Ja)*DPcomp4;

%With deltaPI without noise, random
Ja = JacobianNum(J,PI,PI0,Q,Lrandom); 
%Compute differences in position with geomeric error (experiment) & native
%model
DPcomp5 = getMiddlePoint(WR1) - getMiddlePoint(WR0);
DPIcomp5 = pinv(Ja)*DPcomp5;

%With deltaPI with noise, random
Ja = JacobianNum(J,PI,PI0,Q,Lrandom); 
%Compute differences in position with geomeric error (experiment) & native
%model
DPcomp6 = getMiddlePoint(WR1noise) - getMiddlePoint(WR0);
DPIcomp6 = pinv(Ja)*DPcomp6;

%%%%%%%%   Comparison of designed and random configurations    %%%%%%%%%%%
%Errors
Err1 = DPIcomp1;
Err2 = -DPIcomp2+DPI0';
Err3 = -DPIcomp3+DPI0';
Err4 = DPIcomp4;
Err5 = -DPIcomp5+DPI0';
Err6 = -DPIcomp6+DPI0';

%means
m=zeros(6,1);
m(1) = mean(Err1);
m(2) = mean(Err2);
m(3) = mean(Err3);
m(4) = mean(Err4);
m(5) = mean(Err5);
m(6) = mean(Err6);

%Standard deviations
s=zeros(6,1);
s(1) = std(Err1);
s(2) = std(Err2);
s(3) = std(Err3);
s(4) = std(Err4);
s(5) = std(Err5);
s(6) = std(Err6);

figure;
names = {['-' char(916) char(960) ',+noise,designed']; ['+' char(916) char(960) ',-noise,designed']; ['+' char(916) char(960) ',+noise,designed']; ['-' char(916) char(960) ',+noise,random']; ['+' char(916) char(960) ',-noise,random']; ['+' char(916) char(960) ',+noise,random']};
errorbar(m,s,'o','MarkerSize',5,...
    'MarkerEdgeColor','red','MarkerFaceColor','red',...
    'LineWidth',1.5)
grid on
set(gca,'xtick',[1:6],'xticklabel',names,'FontSize',14)
title('Comparison of designed and random configurations');
