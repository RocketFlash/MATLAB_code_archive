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

param=2;                        %number of parameters
scouts=50;                     %number of scouts
bestbees=5;                    %number of bees , witch going to the best place
selectbees=3;                  %number of bees ,witch going to the selected place
numbest=2;                      %number of best routes
numselect=5;                    %number of selected routes

% right=[0.7 77 2 35];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%   Read data from file   %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lib(10,1)=struct('matrx',0);
noize={%'noize\FN_1000_H01_3_NORM.mat',...
       %'noize\FN_1000_H02_3_NORM.mat',...
       %'noize\FN_1000_H03_3_NORM.mat',...
       %'noize\FN_1000_H04_3_NORM.mat',...
       %'noize\FN_1000_H05_3_NORM.mat',...
       %'noize\FN_1000_H06_3_NORM.mat',...
       %'noize\FN_1000_H07_3_NORM.mat',...
       %'noize\FN_1000_H08_3_NORM.mat',...
       'noize\FN_1000_H09_3_NORM.mat'...
};
err=0.05;
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
% for nz=1:length(err)
% ncurve([2200 2250 2350],noize{1},err(nz));
% ncurve([2200 2350],noize{1},err);
% [X,Yexp,s]=readdata('datar_without_noize.txt',2);
% num=length(s);
% Matrix=zeros(10,num*param);
% [wmax,amax]=wamaxsearch(X,Yexp);

A=importdata('spec.asc');
A=A';
X=A(1,13618:13834);
Yexp=A(2,13618:13834);
Yexp=Yexp';
if Yexp(1)>Yexp(end)
Yexp=Yexp-Yexp(end);
else
Yexp=Yexp-Yexp(1);
end
y1=Yexp(1);
y2=Yexp(end);
x1=X(1);
x2=X(end);
Yline=((y2-y1)*((X-x1)/(x2-x1))-y1);
Yexp=Yexp-Yline';

% Matrix=zeros(10,num*param);
s=[553.73 563 582.56]; %580.7
num=length(s);
% [pks locs]=findpeaks(-diff(Yexp,2)-0.1*(max(diff(Yexp,2))));
% num = size(pks,1);                          %number of curves
% s=zeros(1,num); 
% for i=1:num
%     s(i)=X(locs(i));
% end
Yexp=Yexp';
[wmax,amax]=wamaxsearch(X,Yexp);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

astep=amax/10;                      %step in amplitude grad
wstep=wmax/10;                      %step in width grad
sstep=5;                            %step in shift grad

eps=0;
p=1;l=1;
mz=1;
g=0;

% for t1=1:10
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
    Y=Lorentz(X,bees(scouts+(j-1)*bestbees+i,1:size(best,2)),s,param);
    S=SQ(Yexp,Y);
    bees(scouts+(j-1)*bestbees+i,end)=S;
    end
end

for j=1:numselect
    for i=1:selectbees
    bees(scouts+numbest*bestbees+(j-1)*selectbees+i,1:size(selected,2)-1)=inrange(selected(j,:),astep,wstep,sstep,param);
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
% Matrix(t1,1:num)=minimal(1:2:end-1);
% Matrix(t1,num+1:end)=minimal(2:2:end-1);
% mz=0;g=0;
% astep=amax/10;                      %step in amplitude grad
% wstep=wmax/10;                      %step in width grad
% sstep=5;
% end
% lib(nz).matrx=Matrix;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% str1={'O'};
% str2={':T'};
% writexls('newton.xlsx',lib,str1,str2);

Y=Lorentz(X,minimal,s,param);
Yd=zeros(num,length(X));
Yr=zeros(num,length(X));
for i=1:num 
    Yd(i,:)=Lorentz(X,bees(1,2*i-1),bees(1,2*i),s(i),1);
end
% for i=1:num 
%     Yr(i,:)=Lorentz(X,right((2*i-1):(2*i)),s(i),0);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%       Graph       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1=figure(1);
% subplot(1,2,1);
hold on
h1=plot(X,Yexp,'--k');
h2=plot(X,sum(Yd),'-.b');
h3=plot(X,Yd,'r');
% h4=plot(X,Yr,'--g');
hold off
xlabel('Волновое число/см^{-1}','fontsize',14);
ylabel('Интенсивность','fontsize',14);
grid on
% subplot(1,2,2);
set(h1,'Linewidth',2);
set(h2,'Linewidth',2);
set(h3,'Linewidth',2);
set(h4,'Linewidth',2);
figure(2)
h5=plot(0:p-2,err);
xlabel('Wave number','fontsize',14);
ylabel('Intensity','fontsize',14);
set( h5, 'LineWidth', 2 );
grid on
legend([h1 h2 h3(1) h4(1)],'Экспериментальные данные','Суммарный восстановленный АПК','Элементарные составляющие с помощью АПК','Истинные значения');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
toc
