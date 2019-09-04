clear all
close all
       
tic         %time control
num=2;      %number of curves
astep=1;  %step in amplitude grad
wstep=10;  %step in width grad
[X,Y]=readdata('datar_without_noize.txt');
[wmax,amax]=wamaxsearch(X,Y);
%amax=amax/(num-1);
N=100;

s=[-40,30,70,120,150];%shift
%first ants initialization%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P0=antinit(N,2*num,amax,wmax);%X=antinit(N,param,amax,wmax) %X-returned matrix , N-number of ants , param-number of parametrs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y0 = plotP0(P0,X,N,s,num);
plot(X,Y0,X,Y,'--r');
for i=1:size(Y0,1)%amax,wmax,slb,sub - boundaries
 P0(num*2+1,i)=SQ(Y0(i,:),Y);    
end

eps=10;
fid=0.00005;
tol=1000;
p=1;
l=1;
while eps>fid

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
 Ss=SQ(Ys,Y);
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
for j=1:num:size(P0,2)
    P0(:,1:j)=P1(:,1:j);
end
err(p)=P0(end-1,1);
p=p+1;
% a1(l)=P0(1,1);
% a2(l)=P0(3,1);
% a3(l)=P0(5,1);
% a4(l)=P0(7,1);
% w1(l)=P0(2,1);
% w2(l)=P0(4,1);
% w3(l)=P0(6,1);
% w4(l)=P0(8,1);
% l=l+1;
eps=eps/2;
astep=astep/1.2;
wstep=wstep/1.2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Yq1 = Lorents(X,1,1,P0(1,1),P0(2,1),s(1));
Yq2 = Lorents(X,1,1,P0(3,1),P0(4,1),s(2));
% Yq3 = Lorents(X,1,1,P0(5,1),P0(6,1),s(3));
% Yq4 = Lorents(X,1,1,P0(7,1),P0(8,1),s(4));
subplot(1,2,1);
h1=plot(X,Y0(1:10,:),X,Y,'.b',X,Yq1,'--r',X,Yq2,'--r');%,X,Yq3,'--r',X,Yq4,'--r');
xlabel('frequency');
ylabel('intensity');
subplot(1,2,2);
h2=plot(0:length(err)-1,err);
set( h2, 'LineWidth', 2 );
xlabel('iteration');
ylabel('error');
grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lw=1.5;
% fig2=figure(2);
% subplot(4,1,1);
% plot(0:length(a1)-1,a1,'Linewidth',lw);
% grid on
% ylabel('a1');
% subplot(4,1,2);
% plot(0:length(a2)-1,a2,'Linewidth',lw);
% grid on
% ylabel('a2');
% subplot(4,1,3);
% plot(0:length(a3)-1,a3,'Linewidth',lw);
% grid on
% ylabel('a3');
% subplot(4,1,4);
% plot(0:length(a4)-1,a4,'Linewidth',lw);
% grid on
% ylabel('a4');
% xlabel('iteration');
% %%%%%%%%%%%%%%%%%%%%%%%%%%
% fig3=figure(3);
% subplot(4,1,1);
% plot(0:length(w1)-1,w1,'Linewidth',lw);
% grid on
% ylabel('w1');
% subplot(4,1,2);
% plot(0:length(w2)-1,w2,'Linewidth',lw);
% grid on
% ylabel('w2');
% subplot(4,1,3);
% plot(0:length(w3)-1,w3,'Linewidth',lw);
% grid on
% ylabel('w3');
% subplot(4,1,4);
% plot(0:length(w4)-1,w4,'Linewidth',lw);
% grid on
% ylabel('w4');
% xlabel('iteration');
toc