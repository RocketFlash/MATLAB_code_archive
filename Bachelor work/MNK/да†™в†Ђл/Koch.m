function z=Koch(N)
% функция, возвращающая изображение кривой  оха
x1=0; y1=0; % левая точка начального отрезка
x2=1; y2=0; % права€я точка начального отрезка
figure(1); axis([0 1 0 1]); set(gca,ТXColorТ,ТwТ,ТYColorТ,ТwТ);
hold on;
Coord(x1,y1,x2,y2,N);
% вызов рекурсивной функции, прорисовывающей кривую  оха
function z=Coord(x1,y1,x2,y2,n)
% рекурсивная функци€, прорисовывающая кривую  оха
if n>0
% вычисление координат концов отрезков на очередном шаге рекурсии
dx=(x2-x1)/3; dy=(y2-y1)/3;
x1n=x1+dx; y1n=y1+dy;
x2n=x1+2*dx; y2n=y1+2*dy;
xmid=dx/2-dy*sin(pi/3)+x1n; ymid=dy/2+dx*sin(pi/3)+y1n;
% рекурсия
Coord(x1,y1,x1n,y1n,n-1);
Coord(x1n,y1n,xmid,ymid,n-1);
Coord(xmid,ymid,x2n,y2n,n-1);
Coord(x2n,y2n,x2,y2,n-1);
else
r1=[x1 y1]; r2=[x2 y2]; R=cat(1,r1,r2);
plot(R(:,1),R(:,2),'Color','k');
end