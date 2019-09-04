% 1-слаборазрешенный контур считаем, что центры линий известны (4 метода)
% 2-шум 5 % (4метода)
% 3-трехкомпонентный контур (слаборазрешенный)
% 
% 
% 
% 
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
sstep=5;                            %step in shift grad

eps=0;
p=1;l=1;
mz=1;
g=0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bees=ones(scouts+bestbees*numbest+selectbees*numselect,num*param+1);
minimal=ones(1,size(bees,2));
while bees(1,end) >= eps

beescouts=beescoutsinit(scouts,num,amax,wmax,s,param,X,Yexp);%scouts initialization
%bees matrix init
best(1:numbest,:)=bees(1:numbest,:);
selected(1:numselect,:)=bees((numbest+1:numbest+numselect),:);
bees=zeros(scouts+bestbees*numbest+selectbees*numselect,size(beescouts,2));
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

for m=1:num
a(m,l)=bees(1,2*m-1);
w(m,l)=bees(1,2*m);
end
l=l+1;

if bees(1,end)<minimal(end)
minimal=bees(1,:);
mz=1;
else 
    mz=mz+1;
    bees(2:end,:)=bees(1:end-1,:);
    bees(1,:)=minimal;
end

if mz>10
    astep=astep/2;
    wstep=wstep/2;
    sstep=sstep/2;
    g=g+1;
    mz=1;
end

if g>15
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%     Each parametr changing         %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fig2=figure(2);
% subplot(4,1,1);
% plot(0:length(a1)-1,a1,'Linewidth',2);
% grid on
% ylabel('a1');
% subplot(4,1,2);
% plot(0:length(a2)-1,a2,'Linewidth',2);
% grid on
% ylabel('a2');
% subplot(4,1,3);
% plot(0:length(a3)-1,a3,'Linewidth',2);
% grid on
% ylabel('a3');
% subplot(4,1,4);
% plot(0:length(a4)-1,a4,'Linewidth',2);
% grid on
% ylabel('a4');
% xlabel('iteration');
% %%%%%%%%%%%%%%%%%%%%%%%%%
% fig3=figure(3);
% subplot(4,1,1);
% plot(0:length(w1)-1,w1,'Linewidth',2);
% grid on
% ylabel('w1');
% subplot(4,1,2);
% plot(0:length(w2)-1,w2,'Linewidth',2);
% grid on
% ylabel('w2');
% subplot(4,1,3);
% plot(0:length(w3)-1,w3,'Linewidth',2);
% grid on
% ylabel('w3');
% subplot(4,1,4);
% plot(0:length(w4)-1,w4,'Linewidth',2);
% grid on
% ylabel('w4');
% xlabel('iteration');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc
