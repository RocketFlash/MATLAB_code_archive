function Y0 = plotP0(P0,X,N,s,num)
a=ones(num,N);
w=ones(num,N);
k=1;
for j=1:num
a(j,:)=P0(k,:);
w(j,:)=P0(k+1,:);
k=k+2;
end

Y0=Lorents(X,N,num,a,w,s);

end

