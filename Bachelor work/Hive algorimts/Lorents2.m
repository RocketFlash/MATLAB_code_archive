function Y = Lorents2(X,a,w,s)
S=0;
for i=1:length(a)
Y=a(i)./(1+((X-s(i)).^2)./(w(i)).^2);
S=S+Y;
end
Y=S;
end

