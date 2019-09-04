function [X,Y] = SumFunction(s1,w1,a1,s2,w2,a2)


num=50;
b=1.5;
X=[-b*num:0.1:b*num];

Y=zeros(length(X));
Y=(a1./(1+((X-s1).^2)/(w1)^2))+(a2./(1+((X-s2).^2)/(w2)^2));


% plot(X1,Y1,'r',X2,Y2,'r',X1,Y,'k');
end

