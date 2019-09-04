function writedata(text,a,b,step,new)
if nargin==3
data=fopen(text,'wb');
fwrite(data,a,'double');
fwrite(data,b,'double');
    
else
data=fopen(text,'wb');
fwrite(data,a,'int');
fwrite(data,b,'int');
fwrite(data,step,'double');
fwrite(data,new,'double');
fclose(data);
end
end


