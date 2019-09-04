function y=percentone(x);
A1=load('percentone.dat');
T1=A1(:,1);
Chi1=A1(:,2);
z=x(1)+x(2)./(T1-x(3));
 y1=(abs(z-Chi1));
plot(T1,Chi1, '.g',T1,z,'.r' );


