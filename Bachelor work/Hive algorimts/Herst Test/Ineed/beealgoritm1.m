clear all
close all

tic                               %time control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param = 2;                        %number of parameters
scouts = 200;                     %number of scouts
bestbees = 15;                    %number of bees , witch going to the best place
selectbees = 8;                  %number of bees ,witch going to the selected place
numbest = 3;                      %number of best routes
numselect = 5;                    %number of selected routes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Matrix=zeros(10,6);
ncurve([2200 2250 2350]);
% A=importdata('spec.asc');
% A=A';
% X=A(1,13618:13834);
% Yexp=A(2,13618:13834);
% Yexp=Yexp';
% if Yexp(1)>Yexp(end)
% Yexp=Yexp-Yexp(end);
% else
% Yexp=Yexp-Yexp(1);
% end
% y1=Yexp(1);
% y2=Yexp(end);
% x1=X(1);
% x2=X(end);
% Yline=((y2-y1)*((X-x1)/(x2-x1))-y1);
% Yexp=Yexp-Yline';
% s=[554.5 582];
[X,Yexp,s] = readdata('datar_without_noize.txt',2);
num=length(s);
Yexp=Yexp';
% A=importdata('spectr.asc');
% A=A';
% X=A(1,13841:14161);
% Yexp=A(2,13841:14161);
% Yexp=Yexp-min(Yexp);
[wmax,amax] = wamaxsearch(X,Yexp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
astep = amax/20;                      %step in amplitude grad
wstep = wmax/20;                      %step in width grad

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%               ITERATIONS                   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eps=0;
p=1;l=1;
mz=1;
g=0;
for t1=1:10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iter=1;                             %interational variable
% outfile = 'out1.gif';               %output gif file
bees=ones(scouts+bestbees*numbest+selectbees*numselect,num*param+1);
minimal=ones(1,size(bees,2));

while bees(1,end) >= eps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%       Animation       %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% hq=plot(bees(1:numbest*bestbees,1),bees(1:numbest*bestbees,2),'go',bees(numbest*bestbees+1:numbest*bestbees+numselect*selectbees,1),bees(numbest*bestbees+1:numbest*bestbees+numselect*selectbees,2),'b+',bees(numbest*bestbees+numselect*selectbees+2:end,1),bees(numbest*bestbees+numselect*selectbees+2:end,2),'rx');
% set(hq,'Linewidth',2)
% axis( [ 0,amax, 0, wmax ] )
% legend('������','�������������','���������');
% f = getframe;
% im=frame2im(f);
% [imind,cm] = rgb2ind(im,256);
%     if iter == 1
%         imwrite(imind,cm,outfile,'gif','DelayTime',0,'LoopCount',inf);
%     else
%         imwrite(imind,cm,outfile,'gif','DelayTime',0.25,'WriteMode','append');
%     end
%  iter=iter+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

beescouts=beescoutsinit(scouts,num,amax,wmax,param);%scouts initialization
%Square error calculation

for i=1:size(beescouts,1)
    Y=Lorentz(X,beescouts(i,:),s,param);
    S=SQ(Yexp,Y);
    beescouts(i,end)=S;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%        bees matrix init        %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
best(1:numbest,:)=bees(1:numbest,:);
selected(1:numselect,:)=bees((numbest+1:numbest+numselect),:);
bees=zeros(scouts+bestbees*numbest+selectbees*numselect,size(beescouts,2));
bees(1:scouts,:)=beescouts(:,:);

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
    g=g+1;
    mz=1;
end

if g>15
    break
end

% err(p)=bees(1,end);
% p=p+1;


end
Matrix(t1,:)=minimal(1:end-1);
end
for i=1:num 
    Yd(i,:)=Lorentz(X,bees(1,(2*i-1):(2*i)),s(i),0);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
h1=plot(X,Yexp,X,Yd,X,sum(Yd),'--k');
grid on
xlabel('frequency');
ylabel('intensity');
fig2=figure(2);
% h2=plot(0:p-2,err);
% xlabel('iteration');
% ylabel('error');
% set( h2, 'LineWidth', 2 );
set( h1, 'LineWidth', 1 );
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc
