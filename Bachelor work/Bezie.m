a1=[0 0];
a3=[-6 10];
a2=[10 0];
times=100;
s1=(a2(1)-a1(1))/times;
s2=(a3(1)-a2(1))/times;
x1=a1(1);
x2=a2(1);
x3=a3(1);
y1=a1(2);
y2=a2(2);
y3=a3(2);
px1=x1;
px2=x2;
py1=y1;
py2=y2;
sx=zeros(1,times);
sy=zeros(1,times);
for i=1:times
    py1 = (((px1)-x1)/(x2-x1))*(y2-y1)+y1;
    py2 = (((px2)-x2)/(x3-x2))*(y3-y2)+y2;
    sx(i)=px1+((px2-px1)/times)*i;
    sy(i)=((sx(i)-px1)/(px2-px1))*(py2-py1)+py1;
    px1 = px1 + s1;
    px2 = px2 + s2;
end
h1=plot(sx,sy);
set(h1,'LineWidth',3);