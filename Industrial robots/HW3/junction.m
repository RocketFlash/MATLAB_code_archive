%function returns descrete points of trapezoids before and after junction
function  [J,Jnew,t]=junction(V,T,disc,num)
%num - junction decrete steps

n = size(V,2);
m = size(V,1);

[J,t,S,F] = generatePoints(V,T,disc);

Jcol = zeros(size(J,1),size(J,2),n);
for i = 1:n
    JJ = reshape(J(:,S(i):F(i)),[size(J(:,S(i):F(i)),1),size(J(:,S(i):F(i)),2),1]);
    Jcol(:,S(i):F(i),i) = JJ;
end

for i = 1:n-1
%    if (sign(V(1,i))==sign(V(1,i+1))) && (sign(V(2,i))==sign(V(2,i+1))) && (sign(V(3,i))==sign(V(3,i+1)))
       for j = 1:n-i
            Jcol(:,:,i+j) = circshift(Jcol(:,:,i+j)',-num)';
       end
%    end
end
Jnew = sum(Jcol,3);
end

