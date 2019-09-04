function hive = hiveinit(N,num,param,amax,wmax)
hive=zeros(N,param*num+1);
for i=1:N
   for j=1:param:param*num 
    hive(i,j)=rand*amax;
    hive(i,j+1)=rand*wmax;
   end
end

end

