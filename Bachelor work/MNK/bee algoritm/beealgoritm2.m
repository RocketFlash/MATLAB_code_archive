clear all
close all

fig=figure(1);
tic                             %time control
num=3;                          %number of curves
param=3;                        %number of parameters
scouts=12;                      %number of scouts
bestbees=6;                     %number of bees , witch going to the best place
selectbees=2;                   %number of bees ,witch going to the selected place
range=5;                        %range of area
numbest=2;                      %number of best routes
numselect=3;                      %number of selected routes
s=[-40,30,70,120,150];
[X,Yexp]=readdata('data.txt');
Yexp=Yexp-min(Yexp);
[wmax,amax]=wamaxsearch(X,Yexp);
wmax=wmax/num;
x=find(Yexp==max(Yexp));
smax=X(x);
astep=10;                      %step in amplitude grad
wstep=10;                      %step in width grad
sstep=(max(X)-min(X))/10;
beescouts=beescoutsinit(scouts,num,amax,wmax,smax);
for i=1:size(beescouts,1)
    Y=Lorentz(X,beescouts(i,:),param);
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
    bees(scouts+(j-1)*bestbees+i,1:size(best,2)-1)=inrange(best(j,:),astep,wstep,sstep,param);
    Y=Lorentz(X,bees(scouts+(j-1)*bestbees+i,1:size(best,2)),param);
    S=SQ(Yexp,Y);
    bees(scouts+(j-1)*bestbees+i,end)=S;
    end
end
for j=1:numselect
    for i=1:selectbees
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)-1)=inrange(selected(j,:),astep,wstep,sstep,param);
    Y=Lorentz(X,bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)),param);
    S=SQ(Yexp,Y);
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,end)=S;
    end
end
bees=sortrows(bees,size(bees,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%              NEXT ITERATIONS                   %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eps=5;
fid=0.1;
p=1;
err=zeros(1,i);
while eps>fid
astep=astep/2;                      %step in amplitude grad
wstep=wstep/2;                      %step in width grad
% sstep=sstep;
while bees(1,end) > eps

beescouts=beescoutsinit(scouts,num,amax,wmax,smax);
for i=1:size(beescouts,1)
    Y=Lorentz(X,beescouts(i,:),param);
    S=SQ(Yexp,Y);
    beescouts(i,end)=S;
end
best(1:numbest,:)=bees(1:2,:);
selected(1:numselect,:)=bees((numbest+1:numbest+numselect),:);
bees=zeros(scouts+bestbees*numbest+selectbees*numselect,size(beescouts,2));
bees(1:size(beescouts,1),:)=beescouts(:,:);
for j=1:numbest
    for i=1:bestbees
    bees(scouts+(j-1)*bestbees+i,1:size(best,2)-1)=inrange(best(j,:),astep,wstep,sstep,param);
    Y=Lorentz(X,bees(scouts+(j-1)*bestbees+i,1:size(best,2)),param);
    S=SQ(Yexp,Y);
    bees(scouts+(j-1)*bestbees+i,end)=S;
    end
end
for j=1:numselect
    for i=1:selectbees
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)-1)=inrange(selected(j,:),astep,wstep,sstep,param);
    Y=Lorentz(X,bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)),param);
    S=SQ(Yexp,Y);
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,end)=S;
    end
end
bees=sortrows(bees,size(bees,2));
err(p)=bees(1,end);
p=p+1;
end
eps=eps/2;
end
Y=Lorentz(X,bees(1,:),param);
% Y1=Lorentz(X,bees(1,1:2),0);
subplot(1,2,1);
h1=plot(X,Yexp,X,Y,'--r');%,X,Y1,'g');
grid on
subplot(2,2,2);
h2=plot(0:p-2,err);
set( h2, 'LineWidth', 2 );
set( h1, 'LineWidth', 1 );
grid on
toc