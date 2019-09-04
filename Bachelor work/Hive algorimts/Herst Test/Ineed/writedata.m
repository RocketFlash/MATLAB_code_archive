function writedata(varargin)
switch nargin
    case 3
        text=varargin{1};
        a=varargin{2};
        b=varargin{3};
data=fopen(text,'wb');
fwrite(data,a,'double');
fwrite(data,b,'double');
    
    case 5
        
        text=varargin{1};
        a=varargin{2};
        b=varargin{3};
        step=varargin{4};
        new=varargin{5};
data=fopen(text,'wb');
fwrite(data,a,'int');
fwrite(data,b,'int');
fwrite(data,step,'double');
fwrite(data,new,'double');
fclose(data);
    case 7
        
        text=varargin{1};
        a=varargin{2};
        b=varargin{3};
        num=varargin{4};
        s=varargin{5};
        step=varargin{6};
        new=varargin{7};
data=fopen(text,'wb');
fwrite(data,a,'int');
fwrite(data,b,'int');
fwrite(data,num,'int');
fwrite(data,s,'double')
fwrite(data,step,'double');
fwrite(data,new,'double');
fclose(data);
end
end


