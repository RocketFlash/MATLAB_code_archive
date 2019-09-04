clear all
close all
       
tic         %time control
num=3;      %number of curves

astep=0.7;  %step in amplitude grad
wstep=0.7;  %step in width grad
[X,Y]=readdata('data2.txt');
Y=Y-min(Y);
[wmax,amax]=wamaxsearch(X,Y);
amax=amax/(num-2);
N=10;

s=[-40,30,70,120,150];%shift
%first ants initialization%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P0=antinit(N,2*num,amax,wmax);%X=antinit(N,param,amax,wmax) %X-returned matrix , N-number of ants , param-number of parametrs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y0 = plotP0(P0,X,N,s,num);
plot(X,Y0,X,Y,'--r');
for i=1:size(Y0,1)%amax,wmax,slb,sub - boundaries
 P0(num*2+1,i)=SQ(Y0(i,:),Y');    
end

eps=0.01;
tol=500;
T=10;
for t=1:T

for j=1:N
    a1=ones(num);
    w1=ones(num);
    Zn=1;
while P0(num*2+1,j)>eps
 r=rand;
 ind=randi(num*2);
 a1=P0(1:2:num*2,j);
 w1=P0(2:2:num*2,j);
 if rem(ind,2)==0
 w1(ind/2)=P0(ind,j)+sign(randn)*wstep;
 else
 a1(ind/2+0.5)=P0(ind,j)+sign(randn)*astep;
 end
 Ys=Lorents2(X,a1,w1,s);
 Ss=SQ(Ys,Y');
 if Ss<P0(num*2+1,j)
   P0(num*2+1,j)=Ss;
   P0(1:2:num*2,j)=a1;
   P0(2:2:num*2,j)=w1;
 end
 Zn=Zn+1;
 if Zn>tol
     break
 end
end
P0(num*2+2,j)=Zn;
end
Y0 = plotP0(P0,X,N,s,num);
P1=sortrows(P0',num*2+2);
P1=P1';
for j=1:5:size(P0,2)
    P0(:,j)=P1(:,j);
    P0(:,j+1)=P1(:,j);
    P0(:,j+2)=P1(:,j);
    P0(:,j+3)=P1(:,j);
    P0(:,j+4)=P1(:,j);
end
eps=eps/2;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Yq1 = Lorents(X,1,1,P0(1,1),P0(2,1),s(1));
Yq2 = Lorents(X,1,1,P0(3,1),P0(4,1),s(2));
Yq3 = Lorents(X,1,1,P0(5,1),P0(6,1),s(3));
% Yq4 = Lorents(X,1,1,P0(7,1),P0(8,1),s(4));
% Yq5 = Lorents(X,1,1,P0(9,1),P0(10,1),s(5));
disp('measurements error:');
disp(P0(7,1));
plot(X,Y0(1:10,:),X,Y,'.b',X,Yq1,'--r',X,Yq2,'--r');%,X,Yq3,'--r',X,Yq4,'--r',X,Yq5,'--r');
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


toc