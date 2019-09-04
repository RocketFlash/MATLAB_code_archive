
function  a = invers(xc,yc)

L1=18;
L2=23;
xa=12.75;
xb=24.25;
ya=-6;
yb=-6;

Lc1 =  sqrt((xc-xa)^2+(yc-ya)^2);
Lc2 =  sqrt((xc-xb)^2+(yc-yb)^2);
 
alpha =   (atan2((yc-ya),(xc-xa)) + acos((L1^2+Lc1^2-L2^2)/(2*L1*Lc1)))-pi/2;
beta = (atan2((yc-yb),(xc-xb)) - acos((L1^2+Lc2^2-L2^2)/(2*L1*Lc2)))- pi/2 ;
alpha = alpha.*180/pi;
beta = beta.*180/pi;
if alpha >= -80 && alpha <= 160 && beta >= -160 && beta <= 80   
a=[alpha -beta] 
else
a=[0 0];
warning('Point is unreacheble');
end

end

