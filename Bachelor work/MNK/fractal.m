function i=fractal(x,y)
iter=20;
k=complex(x,y);
Z=k;
i=1;
while i<=iter
    
   Z=Z^12/(1+Z^8)-Z^5-Z^4+1/Z^6+Z^3+k; %kenny
% Z=Z^2+k;
    if abs(Z)>4
        break
    end
    i=i+1;
end

end

