function [A,B,C,D] = PlaneModelParameters(x1,y1,z1,x2,y2,z2,x3,y3,z3)
a1=x2-x1;
a2=y2-y1;
a3=z2-z1;
b1=x3-x1;
b2=y3-y1;
b3=z3-z1;
d1=(a2*b3)-(a3*b2);
d2=(a1*b3)-(a3*b1);
d3=(a1*b2)-(a2*b1);
A=d1;
B=-d2;
C=d3;
D=(y1*d2)-(x1*d1)-(z1*d3);
end

