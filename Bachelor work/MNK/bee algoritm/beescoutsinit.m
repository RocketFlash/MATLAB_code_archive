function bees = beescoutsinit(varargin)

switch nargin
    case 5
        scouts=varargin{1};
        num= varargin{2};
        amax=varargin{3};
        wmax=varargin{4};
        smax=varargin{5};
        bees=zeros(scouts,2*num+1);
for i=1:scouts
    for j=1:3:2*num
        bees(i,j)=rand*wmax;
        bees(i,j+1)=rand*amax;
        bees(i,j+2)=smax+randsrc*rand*wmax;
    end
end
    case 4
        scouts=varargin{1};
        num= varargin{2};
        amax=varargin{3};
        wmax=varargin{4};
        bees=zeros(scouts,2*num+1);
for i=1:scouts
    for j=1:2*num
        if mod(j,2)==0
        bees(i,j)=rand*wmax;
        else
        bees(i,j)=rand*amax;    
        end
    end
end
end


end

