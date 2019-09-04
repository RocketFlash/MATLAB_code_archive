tic
a=1801;
b=2800;  
step=1;
X=a:step:b;
s=[2200 2250 2350];
number=9;
MNK=zeros(number,6);
Hive=zeros(number,6);
Bee=zeros(number,6);
right=[0.7 2 0.5 77 35 80];
Str1={'B'};
Str2={':G'};
Str3={'I'};
Str4={':N'};
Str5={'P'};
Str6={':U'};
for i=1:number
num=5+11*(i-1);
strmnk=[Str1{1} num2str(num) Str2{1} num2str(num)];
strhive=[Str3{1} num2str(num) Str4{1} num2str(num)];
strbee=[Str5{1} num2str(num) Str6{1} num2str(num)];
MNK(i,:)=xlsread('Herst(5%).xlsx',strmnk);
Hive(i,:)=xlsread('Herst(5%).xlsx',strhive);
Bee(i,:)=xlsread('Herst(5%).xlsx',strbee);
end
MNKerr=zeros(1,number);
Hiveerr=zeros(1,number);
Beeerr=zeros(1,number);
for j=1:number
[MNKerr(j), Hiveerr(j), Beeerr(j)]=HestErr2(MNK(j,:),Hive(j,:),Bee(j,:),right,X,s);
end
X=0.1:0.1:0.1*number;
hold on
h1=plot(X,MNKerr,':k');
set(h1,'Linewidth',2);
h2=plot(X,Hiveerr,'-.b');
set(h2,'Linewidth',2);
h3=plot(X,Beeerr,'--r');
set(h3,'Linewidth',2);
hold off
legend([h1 h2 h3],'ÌÍÊ','ÀĞ×','ÀÏÊ');
toc