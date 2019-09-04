clear all
close all

fig = figure(1);
tic                               %time control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

param = 3;                        %number of parameters
scouts = 300;                     %number of scouts
bestbees = 20;                    %number of bees , witch going to the best place
selectbees = 10;                  %number of bees ,witch going to the selected place
numbest = 2;                      %number of best routes
numselect = 5;                    %number of selected routes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X,Yexp] = readdata('datar_without_noize.txt');
% A=importdata('spec.asc');
% A=A';
% X=A(1,13618:13834);
% Yexp=A(2,13618:13834);
% if Yexp(1)>Yexp(end)
% Yexp=Yexp-Yexp(end);
% else
% Yexp=Yexp-Yexp(1);
% end
[pks locs]=findpeaks(-diff(Yexp,2));
num = size(pks,1);                          %number of curves
s=zeros(1,num); 
for i=1:num
    s(i)=X(locs(i));
end
Yexp=Yexp';
[wmax,amax,sm] = wamaxsearch(X,Yexp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
astep = amax/20;                      %step in amplitude grad
wstep = wmax/20;                      %step in width grad

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%              NEXT ITERATIONS                   %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eps=0;
p=1;l=1;
err=zeros(1,i);
mz=1;
g=0;
bees=ones(scouts+bestbees*numbest+selectbees*numselect,num*param+1);
minimal=ones(1,size(bees,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
iter=1;                             %interational variable
% outfile = 'out1.gif';               %output gif file

while bees(1,end) >= eps
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%       Animation       %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% hq=plot(bees(1:numbest*bestbees,1),bees(1:numbest*bestbees,2),'go',bees(numbest*bestbees+1:numbest*bestbees+numselect*selectbees,1),bees(numbest*bestbees+1:numbest*bestbees+numselect*selectbees,2),'b+',bees(numbest*bestbees+numselect*selectbees+2:end,1),bees(numbest*bestbees+numselect*selectbees+2:end,2),'rx');
% set(hq,'Linewidth',2)
% axis( [ 0,amax, 0, wmax ] )
% legend('Лучшие','Потенциальные','Случайные');
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

err(p)=bees(1,end);
p=p+1;


end


Y=Lorentz(X,minimal,s,param);
Yd=zeros(num,length(X));

for i=1:num 
    Yd(i,:)=Lorentz(X,bees(1,(2*i-1):(2*i)),s(i),0);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1=figure(1);
% subplot(1,2,1);
h1=plot(X,sum(Yd),'--b',X,Yexp,'k',X,Yd,'r');%,X,Y,'--r');
% legend('experimental','1 curve','2 curve','3 curve','4 curve');
xlabel('frequency');
ylabel('intensity');
grid on
% subplot(1,2,2);
fig2=figure(2);
h2=plot(0:p-2,err);
xlabel('iteration');
ylabel('error');
set( h2, 'LineWidth', 2 );
set( h1, 'LineWidth', 1 );
grid on
% fig2=figure(2);

subplot(2,1,1);
plot(0:length(a(1,:))+20,1.3*ones(1,length(a(1,:))+21),'--r',0:length(a(1,:))-1,a(1,:),'Linewidth',2);
grid on
ylabel('a1');
subplot(2,1,2);
plot(0:length(a(1,:))+20,1.5*ones(1,length(a(1,:))+21),'--r',0:length(a(2,:))-1,a(2,:),'Linewidth',2);
grid on
ylabel('a2');
% subplot(4,1,3);
% plot(0:length(a3)-1,a3,'Linewidth',2);
% grid on
% ylabel('a3');
% subplot(4,1,4);
% plot(0:length(a4)-1,a4,'Linewidth',2);
% grid on
% ylabel('a4');
xlabel('iteration');
%%%%%%%%%%%%%%%%%%%%%%%%%
fig3=figure(3);
subplot(2,1,1);
plot(0:length(a(1,:))+20,30*ones(1,length(a(1,:))+21),'--r',0:length(w(1,:))-1,w(1,:),'Linewidth',2);
grid on
ylabel('w1');
subplot(2,1,2);
plot(0:length(a(1,:))+20,98*ones(1,length(a(1,:))+21),'--r',0:length(w(2,:))-1,w(2,:),'Linewidth',2);
grid on
ylabel('w2');
% subplot(4,1,3);
% plot(0:length(w3)-1,w3,'Linewidth',2);
% grid on
% ylabel('w3');
% subplot(4,1,4);
% plot(0:length(w4)-1,w4,'Linewidth',2);
% grid on
% ylabel('w4');
xlabel('iteration');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc
