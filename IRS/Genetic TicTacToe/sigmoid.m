function y = sigmoid(x,t)
X = 1+exp(-t*x);
y = 1./X;
end

