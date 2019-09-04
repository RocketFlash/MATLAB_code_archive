function S = SumSquaresFunction(Y0,a1,a2,w1,w2,s1,s2)

[X,Y1]=SumFunction(s1,w1,a1,s2,w2,a2);

S=0;
for i =1:length(Y0)
S=S+(Y0(i)-Y1(i))^2;
end

end

