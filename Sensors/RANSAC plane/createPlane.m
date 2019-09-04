function [X,Y,Z] = createPlane(A,B,C,D,err)
[X,Y] = meshgrid(0:2:100,0:2:100);
Xerr = err*rand(length(X),length(Y));
Yerr = err*rand(length(X),length(Y));
X=X+Xerr;
Y=Y+Yerr;
Z=-(A*X+B*Y+D)/C;
Zerr = err*rand(length(X),length(Y));
Z=Z+Zerr;
plot3(X,Y,Z,'*r');
end

