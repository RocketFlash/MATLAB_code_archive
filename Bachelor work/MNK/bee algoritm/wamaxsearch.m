function [wmax,amax] = wamaxsearch(X,Y)

amax=max(Y);
q=0;
while q>=0
x=find((Y>=(amax/2))&(Y<=(amax/2)+q));
q=q+0.000001;
if length(x)==2
    break
end

end
wmax=X(x(2))-X(x(1));


end

