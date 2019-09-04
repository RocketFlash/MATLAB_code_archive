function Y = Lorentz(varargin)
switch nargin
    case 3
    X=varargin{1};
    bees=varargin{2};
    param=varargin{3};
    case 4   
    X=varargin{1};
    bees=varargin{2};
    s=varargin{3};
    param=varargin{4};
end
switch param
    case 0
    a=bees(1:2:length(bees));
    w=bees(2:2:length(bees));
    case 2
    a=bees(1:2:length(bees)-1);
    w=bees(2:2:length(bees)-1);
    case 3
    a=bees(1:3:length(bees)-1);
    w=bees(2:3:length(bees)-1);
    s=bees(3:3:length(bees)-1);
end
Y=0;
for i=1:length(a) 
Y=Y+(a(i)./(1+((X-s(i)).^2)./(w(i)^2)));
end
end

