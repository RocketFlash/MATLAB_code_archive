clear all
close all
tic %time control
num=3;
error=0;
lib(1,1)=struct('matrx',0);
Matrix=zeros(1000,6);
noize={%'noize\FN_1000_H01_3_NORM.mat',...
       %'noize\FN_1000_H02_3_NORM.mat',...
       %'noize\FN_1000_H03_3_NORM.mat',...
       %'noize\FN_1000_H04_3_NORM.mat',...
       %'noize\FN_1000_H05_3_NORM.mat'%,...
       %'noize\FN_1000_H06_3_NORM.mat',...
       %'noize\FN_1000_H07_3_NORM.mat',...
       %'noize\FN_1000_H08_3_NORM.mat',...
       'noize\FN_1000_H09_3_NORM.mat'...
};
err=0.1;
% for nz=1:length(err)
% ncurve([2200 2250 2350],noize{1},err(nz));
ncurve([2200 2250 2350],noize{1},err);
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
[X,Y,s]=readdata('datar_with_fnoize.txt',2);
[wmax,amax]=wamaxsearch(X,Y);
% [pks locs]=findpeaks(diff(Yexp,1));
% 
% num = size(pks,1);                          %number of curves
% s=zeros(1,num); 
% for i=1:num
%     s(i)=X(locs(i));
% end
% Yexp=Yexp';
% s=[554.5 582];
for t1=1:2000
%     clear am w
% ncurve([2200 2250+50*t1]);
% for t2=1:3
%     switch t2
%         case 1
% [X,Y,s]=readdata('datar_without_noize.txt',2);
%         case 2
% [X,Y,s]=readdata('datar_with_noize.txt',2);
%         case 3
% [X,Y,s]=readdata('datar_with_fnoize.txt',2);
%     end
%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:num
a(i)=rand*amax;
w(i)=rand*wmax;
end
% [pks locs]=findpeaks(-diff(Y,2));
% num = size(pks,1);                          %number of curves
% s=zeros(1,num); 
% for i=1:num
%     s(i)=X(locs(i));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%

V=[a w];
f = @(V,X)(V(1)./(1+((X-s(1)).^2)/(V(4))^2))+(V(2)./(1+((X-s(2)).^2)/(V(5))^2))+(V(3)./(1+((X-s(3)).^2)/(V(6))^2));
C=lsqcurvefit(f,V,X,Y');
am=C(1:num);
w=C(num+1:2*num);
% Matrix(3*(t1-1)+t2,:)=[am w];
Matrix(t1,:)=[am w];
if am(1)>0.8||am(1)<0.6
    error=error+1;
end
end
lib(1).matrx=Matrix;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% str1={'B'};
% str2={':G'};
% writexls('newton3.xlsx',lib(1),str1,str2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% s=C(2*num+1:3*num);
Yd=zeros(num,length(X));
for i=1:num
Yd(i,:)=am(i)./(1+((X-s(i)).^2)/(w(i))^2);
end
fig=figure(4);
plot(X,sum(Yd),'--b',X,Y,'k',X,Yd,'r');
% legend('a','b','c');
xlabel('frequency');
ylabel('intensity');
grid on;
luck=100-(error/20);
toc


