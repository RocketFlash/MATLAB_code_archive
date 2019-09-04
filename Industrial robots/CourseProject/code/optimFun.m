function Y = optimFun(Q,Pi)
Y = det(sumJacobians(Q,Pi));
end

