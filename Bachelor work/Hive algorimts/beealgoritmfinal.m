clear all
close all

tic                             %time control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

param=3;                        %number of parameters
scouts=200;                     %number of scouts
bestbees=20;                    %number of bees , witch going to the best place
selectbees=10;                  %number of bees ,witch going to the selected place
numbest=2;                      %number of best routes
numselect=5;                    %number of selected routes
decrease=0.5;                   %decreasing range of place
improve=10;                     %stopping criterion
eps=0;                          %stopping criterion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%   Read data from file   %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X,Yexp]=readdata('datar_without_noize.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      Importing data     %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A=importdata('spectr.asc');
% A=A';
% X=A(1,13841:14161);
% Yexp=A(2,13841:14161);
% Yexp=Yexp-min(Yexp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%       Peak detection        %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[wmax,amax]=wamaxsearch(X,Yexp);
[pks locs]=findpeaks(-diff(Yexp,2)-0.1*(max(diff(Yexp,2))));
num = size(pks,1);                          %number of curves
s=zeros(1,num); 
for i=1:num
    s(i)=X(locs(i));
end
Yexp=Yexp';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

astep=amax/10;                      %step in amplitude grad
wstep=wmax/10;                      %step in width grad
sstep=(X(end)-X(1))/100;            %step in shift grad
g=0;err=0;p=1;mz=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bees=ones(scouts+bestbees*numbest+selectbees*numselect,num*param+1);
bees(:,end)=inf;
beescouts=beescoutsinit(scouts,num,amax,wmax,s,param,X,Yexp);

bees(1:scouts,:)=beescouts(:,:);
minimal=ones(1,size(bees,2));
while bees(1,end) > eps

beescouts=beescoutsinit(scouts,num,amax,wmax,s,param,X,Yexp);%scouts initialization
%bees matrix init
bees=sortrows(bees,size(bees,2));
best(1:numbest,:)=bees(1:numbest,:);
selected(1:numselect,:)=bees((numbest+1:numbest+numselect),:);
bees=ones(scouts+bestbees*numbest+selectbees*numselect,num*param+1);
bees(1:scouts,:)=beescouts(:,:);



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

if bees(1,end)<minimal(end)
minimal=bees(1,:);
mz=1;
else 
    mz=mz+1;
    bees(2:end,:)=bees(1:end-1,:);
    bees(1,:)=minimal;
end

if mz>10
    astep=astep*decrease;
    wstep=wstep*decrease;
    sstep=sstep*decrease;
    g=g+1;
    mz=1;
end

if g>improve
    break
end

err(p)=bees(1,end);
p=p+1;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y=Lorentz(X,minimal,param);
Yd=zeros(num,length(X));
for i=1:num 
    Yd(i,:)=Lorentz(X,bees(1,3*i-2),bees(1,3*i-1),bees(1,3*i),1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%       Graph       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1=figure(1);
subplot(1,2,1);
h1=plot(X,Yexp,'k',X,Yd,'r');
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

toc