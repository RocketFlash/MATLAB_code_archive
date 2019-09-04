function [X,Y] = readdata(text)
if strcmp('newdata.txt',text)
data=fopen(text,'rb');
X=fread(data,1001,'double');
Y=fread(data,1001,'double');
else
data=fopen(text,'rb');
a=fread(data,1,'int');
b=fread(data,1,'int');
step=fread(data,1,'double');
X=a:step:b;
Y=fread(data,length(X),'double');
fclose(data);
end
end

