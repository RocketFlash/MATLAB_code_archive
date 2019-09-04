function S=errcount(X,A,B,C)
num=length(A)/2;
Y1=Lorentz(X,A(1:num),A(num+1:end),C,1);
Y2=Lorentz(X,B(1:num),B(num+1:end),C,1);
S=SQ(Y1,Y2);
end