tic
a=1801;
b=2800;  
step=1;
X=a:step:b;
s=[2200 2250 2350];
number=9;
Q1=zeros(1,9);
Q2=zeros(1,9);
Q3=zeros(1,9);
MNK=zeros(100,6);
Hive=zeros(10,6);
Bee=zeros(10,6);
right=[0.7 2 0.5 77 35 80];
Str1={'B'};
Str2={':G'};
Str3={'I'};
Str4={':N'};
Str5={'P'};
Str6={':U'};
for i=1:number
num=3+102*(i-1);
num1=3+11*(i-1);
strmnk=[Str1{1} num2str(num) Str2{1} num2str(num+99)];
strhive=[Str3{1} num2str(num1) Str4{1} num2str(num1+9)];
strbee=[Str5{1} num2str(num1) Str6{1} num2str(num1+9)];
MNK(:,:)=xlsread('newton2.xlsx',strmnk);
Hive(:,:)=xlsread('newton.xlsx',strhive);
Bee(:,:)=xlsread('newton.xlsx',strbee);
MNKerr=zeros(1,99);
Hiveerr=zeros(1,9);
Beeerr=zeros(1,9);
t=0;
for j=1:100
    if mod(j,10)==1
        t=t+1;
    end
[MNKerr(j), Hiveerr(j), Beeerr(j)]=HestErr2(MNK(j,:),Hive(t,:),Bee(t,:),right,X,s);
end
Q1(i)=mean(MNKerr);
Q2(i)=mean(Hiveerr);
Q3(i)=mean(Beeerr);
end

X=1:1:number;
hold on
h1=plot(X,Q1(1:9),':k');
set(h1,'Linewidth',2);
h2=plot(X,Q2,'-.b');
set(h2,'Linewidth',2);
h3=plot(X,Q3,'--r');
set(h3,'Linewidth',2);
hold off
legend([h1 h2 h3],'ÃÕ ','¿–◊','¿œ ');
toc