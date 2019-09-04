function opt = sumsquares(V,Y,X)
Yd=zeros(length(V)/3,length(X));
am=V(1:length(V)/3);
w=V(length(V)/3+1:2*length(V)/3);
s=V(2*length(V)/3+1:length(V));
for j=1:length(V)/3
Yd(j,:)=(am(j)./(1+((X-s(j)).^2)/(w(j))^2));
end
Ysum=sum(Yd);
ot=(Y - Ysum).^2;
opt=sum(ot);
end

