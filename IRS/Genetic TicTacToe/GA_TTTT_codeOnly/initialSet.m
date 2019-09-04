% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = initialSet(n,m)
res = zeros(n,2,m);
for i=1:n
    res(i,:,:) = rand(2,m);
end
res = res*100-50;
end