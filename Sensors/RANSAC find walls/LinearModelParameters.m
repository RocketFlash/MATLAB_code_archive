function [A,B,C] = LinearModelParameters(x1,y1,x2,y2)
A=y1-y2;
B=x2-x1;
C=x1*y2-x2*y1;
end

