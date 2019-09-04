function [wmax,amax] = wamaxsearch(X,Y)

amax=max(Y);
xmax=find(Y==amax);
x1=0;
x2=0;
q=0;
while(1)
x1=find((Y(1:xmax)>=(amax/2))&(Y(1:xmax)<=(amax/2)+q));
if(~isempty(x1))
   break 
end
q=q+0.00001;
end
q=0;
while(1)
x2=find((Y(xmax:end)>=(amax/2))&(Y(xmax:end)<=(amax/2)+q));
if(~isempty(x2))
   break 
end
q=q+0.00001;
end

wmax=(X(max(x1))-X(max(x2)));
end

