function [X,Yerr] = createPeriodicFunction(err)
X = 0:0.05:100;
Y = 7*sin(0.5*X)+4*sin(X)+3*sin(X/7);
noize = err*randn(1,length(Y));
Yerr = Y + noize;
end

