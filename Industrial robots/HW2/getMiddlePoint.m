function P = getMiddlePoint(W)
%TODO 
n = size(W,1);
m = size(W,2);
p = size(W,3);
P = zeros(n*3,1);
for i=1:n
    for j=1:m
        for k = 1:p
            P((3*i-2):(3*i)) = P((3*i-2):(3*i))+ squeeze(W(i,j,k,:));
        end
    end
end
P = P/(m*p);
end

