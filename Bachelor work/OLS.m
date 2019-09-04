clear all;
close all;
global b;
b=1;
s1=5; %shift 1
s2=20;%shift 2
w1=10;%width 1
w2=10;%width 2
a1=8; %amplitude 1
a2=20;%amplitude 2
afid=1;
w1ub=17;
w2ub=25;
wfid=1;
[X,Y]=SumFunction(s1,w1,a1,s2,w2,a2);%shift,width,amplitude of the 2 curves
[a1,a2,w1,w2]=MNK(Y,s1,s2,afid,w1ub,w2ub,wfid);%Y0,s1,s2,a1ub,a2ub,afid,w1ub,w2ub,wfid
[X1,Y1]=Lorentz(s1,a1,w1);
[X2,Y2]=Lorentz(s2,a2,w2);
[X3,Y3]=SumFunction(s1,w1,a1,s2,w2,a2);
plot(X,Y,X1,Y1,'r',X2,Y2,'r',X3,Y3,'k--');