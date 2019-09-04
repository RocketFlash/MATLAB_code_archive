function X=antinit(N,param,amax,wmax) %X-returned matrix , N-number of ants , param-numver of parametrs
                                              %amax,wmax,slb,sub - boundaries
X=zeros(param,N);
for i=1:param
    for j=1:N
        r=rand;
        if mod(i,2)==0
        X(i,j)=wmax*r;
        else
        X(i,j)=amax*r;    
        end
        
    end
end

end

