function [X,Y] = readdata(text)
if strcmp('newdata.txt',text)
data=fopen(text,'rb');
X=fread(data,564,'double');
Y=fread(data,564,'double');
else
data=fopen(text,'rb');
a=fread(data,1,'int');
b=fread(data,1,'int');
step=fread(data,1,'double');
X=2*pi*a:2*pi*step:2*pi*b;
Y=fread(data,length(X),'double');
fclose(data);
end
end

