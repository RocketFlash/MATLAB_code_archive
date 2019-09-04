clear all
close all

fig=figure(1);
tic                             %time control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num=5;                          %number of curves
param=2;                        %number of parameters
scouts=200;                     %number of scouts
bestbees=6;                     %number of bees , witch going to the best place
selectbees=2;                   %number of bees ,witch going to the selected place
range=5;                        %range of area
numbest=2;                      %number of best routes
numselect=5;                      %number of selected routes
s=[-40,30,70,120,150];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X,Yexp]=readdata('data_without_noize.txt');
Yexp=Yexp-min(Yexp);
[wmax,amax]=wamaxsearch(X,Yexp);
wmax=wmax/num;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
astep=1;                      %step in amplitude grad
wstep=10;                      %step in width grad
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%        FIRST ITERATION       %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
beescouts=beescoutsinit(scouts,num,amax,wmax);
for i=1:size(beescouts,1)
    Y=Lorentz(X,beescouts(i,:),s,param);
    S=SQ(Yexp,Y);
    beescouts(i,end)=S;
end
beescouts=sortrows(beescouts,size(beescouts,2));
best(1:numbest,:)=beescouts(1:2,:);
selected(1:numselect,:)=beescouts((numbest+1:numbest+numselect),:);
bees=zeros(scouts+bestbees*numbest+selectbees*numselect,size(beescouts,2));
bees(1:size(beescouts,1),:)=beescouts(:,:);
for j=1:numbest
    for i=1:bestbees
    bees(scouts+(j-1)*bestbees+i,1:size(best,2)-1)=inrange(best(j,:),astep,wstep,param);
    Y=Lorentz(X,bees(scouts+(j-1)*bestbees+i,1:size(best,2)),s,param);
    S=SQ(Yexp,Y);
    bees(scouts+(j-1)*bestbees+i,end)=S;
    end
end
for j=1:numselect
    for i=1:selectbees
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)-1)=inrange(selected(j,:),astep,wstep,param);
    Y=Lorentz(X,bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)),s,param);
    S=SQ(Yexp,Y);
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,end)=S;
    end
end
bees=sortrows(bees,size(bees,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%              NEXT ITERATIONS                   %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eps=5;
fid=0.0001;
p=1;l=1;
err=zeros(1,i);
start=1;
stop=0;
m=1;
g=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while eps>fid
astep=astep/1.3;                      %step in amplitude grad
wstep=wstep/1.3;                      %step in width grad
if g==1
break
end
while bees(1,end) > eps

if start<=stop
    m=m+1;
end
if m>1000
g=1;
break
end
start=stop;
beescouts=beescoutsinit(scouts,num,amax,wmax);
for i=1:size(beescouts,1)
    Y=Lorentz(X,beescouts(i,:),s,param);
    S=SQ(Yexp,Y);
    beescouts(i,end)=S;
end
best(1:numbest,:)=bees(1:2,:);
selected(1:numselect,:)=bees((numbest+1:numbest+numselect),:);
bees=zeros(scouts+bestbees*numbest+selectbees*numselect,size(beescouts,2));
bees(1:size(beescouts,1),:)=beescouts(:,:);
for j=1:numbest
    for i=1:bestbees
    bees(scouts+(j-1)*bestbees+i,1:size(best,2)-1)=inrange(best(j,:),astep,wstep,param);
    Y=Lorentz(X,bees(scouts+(j-1)*bestbees+i,1:size(best,2)),s,param);
    S=SQ(Yexp,Y);
    bees(scouts+(j-1)*bestbees+i,end)=S;
    end
end
for j=1:numselect
    for i=1:selectbees
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)-1)=inrange(selected(j,:),astep,wstep,param);
    Y=Lorentz(X,bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)),s,param);
    S=SQ(Yexp,Y);
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,end)=S;
    end
end
bees=sortrows(bees,size(bees,2));
err(p)=bees(1,end);
p=p+1;
for m=1:num
a(m,l)=bees(1,2*m-1);
w(m,l)=bees(1,2*m);
end
l=l+1;
stop=bees(1,end);
end

eps=eps/5;
end
Y=Lorentz(X,bees(1,:),s,param);
Yd=zeros(num,length(X));
for i=1:num 
    Yd(i,:)=Lorentz(X,bees(1,(2*i-1):(2*i)),s(i),0);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1=figure(1);
subplot(1,2,1);
h1=plot(X,Yexp,'k',X,Yd,'r');%,X,Y,'--r');
% legend('experimental','1 curve','2 curve','3 curve','4 curve');
xlabel('frequency');
ylabel('intensity');
grid on
subplot(1,2,2);
h2=plot(0:p-2,err);
xlabel('iteration');
ylabel('error');
set( h2, 'LineWidth', 2 );
set( h1, 'LineWidth', 1 );
grid on
fig2=figure(2);

subplot(4,1,1);
plot(0:length(a1)-1,a1,'Linewidth',2);
grid on
ylabel('a1');
subplot(4,1,2);
plot(0:length(a2)-1,a2,'Linewidth',2);
grid on
ylabel('a2');
subplot(4,1,3);
plot(0:length(a3)-1,a3,'Linewidth',2);
grid on
ylabel('a3');
subplot(4,1,4);
plot(0:length(a4)-1,a4,'Linewidth',2);
grid on
ylabel('a4');
xlabel('iteration');
%%%%%%%%%%%%%%%%%%%%%%%%%
fig3=figure(3);
subplot(4,1,1);
plot(0:length(w1)-1,w1,'Linewidth',2);
grid on
ylabel('w1');
subplot(4,1,2);
plot(0:length(w2)-1,w2,'Linewidth',2);
grid on
ylabel('w2');
subplot(4,1,3);
plot(0:length(w3)-1,w3,'Linewidth',2);
grid on
ylabel('w3');
subplot(4,1,4);
plot(0:length(w4)-1,w4,'Linewidth',2);
grid on
ylabel('w4');
xlabel('iteration');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc
