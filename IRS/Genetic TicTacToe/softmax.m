function Y = softmax(X)
Y = exp(X)/sum(exp(X));
end

