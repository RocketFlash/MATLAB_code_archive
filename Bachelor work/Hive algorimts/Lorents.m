function Y = Lorents(X,N,num,a,w,s)
Y=ones(N,length(X));
if size(a)==1
Y=a./(1+((X-s).^2)./(w).^2);
else

for j=1:N 
for k=1:num    
Yu(k,:)=a(k,j)./(1+((X-s(k)).^2)./(w(k,j)).^2);
end
Y(j,:)=sum(Yu);
end
end


end

