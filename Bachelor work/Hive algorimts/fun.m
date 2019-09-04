function Y = fun(V,X)
am=V(1:length(V)/3);
w=V(length(V)/3+1:2*length(V)/3);
% s=V(2*length(V)/3+1:length(V));
for j=1:length(V)/3
Yd(j,:)=(am(j)./(1+((X-s(j)).^2)/(w(j))^2));
end
Y=sum(Yd);
end

