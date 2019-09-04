function hive = hiveinit(N,num,param,s,amax,wmax)
hive=zeros(N,param*num+1);
t=1;
for i=1:N
   for j=1:param:param*num 
    hive(i,j)=rand*amax;
    hive(i,j+1)=rand*wmax;
    hive(i,j+2)=s(t)+5*randn*randsrc;
    t=t+1;
   end
   t=1;
end

end

