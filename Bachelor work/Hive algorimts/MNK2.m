clear all
close all
tic %time control
num=2;

[X,Y]=readdata('datar_without_noize.txt');
%%%%%%%%%%%%%%%%%%%%%%%%%%
[wmax,amax] = wamaxsearch(X,Y);
x=find(Y==amax);
for i=1:num
a(i)=1/amax;
w(i)=wmax;
end
[pks locs]=findpeaks(-diff(Y,2));
num = size(pks,1);                          %number of curves
s=zeros(1,num); 
for i=1:num
    s(i)=X(locs(i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%

V=[0.5 0.5 30 30];
f = @(V,X)(V(1)./(1+((X-s(1)).^2)/(V(3))^2))+(V(2)./(1+((X-s(2)).^2)/(V(4))^2));
C=lsqcurvefit(f,V,X,Y');
am=C(1:num);
w=C(num+1:2*num);
% s=C(2*num+1:3*num);
Yd=zeros(num,length(X));
for i=1:num
Yd(i,:)=am(i)./(1+((X-s(i)).^2)/(w(i))^2);
end
fig=figure(4);
plot(X,sum(Yd),'--b',X,Y,'k',X,Yd,'r');

xlabel('frequency');
ylabel('intensity');
grid on;

toc


