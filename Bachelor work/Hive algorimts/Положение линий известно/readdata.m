function [varargout] = readdata(text,param)

switch param
    case 1
data=fopen(text,'rb');
a=fread(data,1,'int');
b=fread(data,1,'int');
step=fread(data,1,'double');
varargout{1}=a:step:b;
varargout{2}=fread(data,length(X),'double');
fclose(data);
    case 2
data=fopen(text,'rb');
a=fread(data,1,'int');
b=fread(data,1,'int');
num=fread(data,1,'int');
s=fread(data,num,'double');
step=fread(data,1,'double');

X=a:step:b;
varargout{1}=X;
varargout{2}=fread(data,length(X),'double');
varargout{3}=s;
fclose(data);
end

