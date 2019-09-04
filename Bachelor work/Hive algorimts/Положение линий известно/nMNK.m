clear all
close all
tic %time control
num=2;

[X,Y]=readdata('datar_without_noize.txt');
%%%%%%%%%%%%%%%%%%%%%%%%%%
% [wmax,amax] = wamaxsearch(X,Y);
% x=find(Y==amax);
% for i=1:num
% a(i)=1/amax;
% s(i)=1;
% w(i)=wmax;
% end
s=[2250,2350,2450];
%%%%%%%%%%%%%%%%%%%%%%%%%%%

V=[0 0 0 0 0 0 s(1) s(2) s(3)];
options=optimset('Display','final','MaxFunEvals',100000,'MaxIter',100000,'TolX', 1e-50, 'Tolfun',1e-50);
C=fminsearch(@sumsquares,V,options,Y',X);
am=C(1:num);
w=C(num+1:2*num);
s=C(2*num+1:3*num);
Yd=zeros(num,length(X));
for i=1:num
Yd(i,:)=am(i)./(1+((X-s(i)).^2)/(w(i))^2);
end

plot(X,Y,'r',X,Yd,'b');

for j=1:num
text(-300,amax-(j-1)*4,strcat('curve #',num2str(j)));
text(-300,amax-(j-1)*4-1,strcat('am=',num2str(am(j))));
text(-300,amax-(j-1)*4-2,strcat('w=',num2str(w(j))));
text(-300,amax-(j-1)*4-3,strcat('s=',num2str(s(j))));
end

xlabel('frequency');
ylabel('intensity');
grid on;

toc


