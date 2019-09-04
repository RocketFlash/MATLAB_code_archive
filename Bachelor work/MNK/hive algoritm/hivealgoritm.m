clear all
close all
tic                             %time control

num=5;                          %number of curves
param=2;                        %number of parameters                    
eps=0.001;                     %maximum error
s=[-40,30,70,120,150];          %theoretical shift
% wt=[30 30 17 12 13];            %theoretical width
% at=[10 10 1.8 2 1.3];           %theoretical amplitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X,Yexp]=readdata('data_without_noize.txt');
Yexp=Yexp-min(Yexp);
[wmax,amax]=wamaxsearch(X,Yexp);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=1000;
Pp=2;
Pg=2.1;
Ph=Pp+Pg;
k=0.8;
p=1;
Xhi=(2*k)/(abs(2-Ph-sqrt(Ph^2-4*Ph)));
% for N=100:10:1000
hive=hiveinit(N,num,param,amax,wmax);
speed=zeros(size(hive));
speed=speed(:,1:end-1);
for i=1:size(hive,1)
    Y=Lorentz(X,hive(i,:),s,param);
    S=SQ(Yexp,Y);
    hive(i,end)=S;
end
hivebest=hive;
x=find(hive(:,end) == min(hive(:,end)));
thebest=hive(x,:);
all=zeros(5000);
all(1)=thebest(1,end);
l=2;
start=1;
stop =1;
m=1;
while thebest(1,end)>eps
    start=thebest(1,end);
    if start==stop
        m=m+1;
    else m=1;
    end
    if m>100
        break
    end
    for i=1:N
        for j=1:num*param
            speed(i,j)=Xhi*(speed(i,j)+Pp*rand*(hivebest(i,j)-hive(i,j))+Pg*rand*(thebest(j)-hive(i,j)));
        end
    end
    for i=1:N
        for j=1:num*param
            hive(i,j)=hive(i,j)+speed(i,j);
        end
    end
    for i=1:size(hive,1)
        Y=Lorentz(X,hive(i,:),s,param);
        S=SQ(Yexp,Y);
        hive(i,end)=S;
        if hive(i,end)<hivebest(i,end)
            hivebest(i,:)=hive(i,:);
        end
    end
    x=find(hivebest(:,end) == min(hivebest(:,end)));
    thebest=hivebest(x,:);
    all(l)=thebest(1,end);
    l=l+1;
    stop=thebest(1,end);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ae=thebest(1,1:end-1);
at=[10 30 15 35 20 37 20 30 10 30];
% Rz(p)=N;
% Qz(p)=sum(abs(ae-at));
% p=p+1;
% end

Yd=zeros(num,length(X));
for i=1:num 
    Yd(i,:)=Lorentz(X,thebest(1,(2*i-1):(2*i)),s(i),0);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,2,1);
plot(X,Yexp,'.b',X,Yd,'g');
xlabel('frequency');
ylabel('intensity');
grid on
subplot(1,2,2);
all(all==0)=[];
plot(0:length(all)-1,all);
xlabel('iteration');
ylabel('error');
grid on

f3=figure(3);
h4=plot(Rz,Qz);
toc