function bees = beescoutsinit(varargin)

switch nargin
    case 8
        scouts=varargin{1};
        num= varargin{2};
        amax=varargin{3};
        wmax=varargin{4};
        s=varargin{5};
        param=varargin{6};
        X=varargin{7};
        Yexp=varargin{8};
        bees=zeros(scouts,param*num+1);
        t=1;
for i=1:scouts
    for j=1:3:2*num
        bees(i,j)=rand*wmax;
        bees(i,j+1)=rand*amax;
        bees(i,j+2)=s(t);
        t=t+1;
    end
    t=1;
end
for i=1:scouts
    Y=Lorentz(X,bees(i,:),param);
    S=SQ(Yexp,Y);
    bees(i,end)=S;
end
    case 5
        scouts=varargin{1};
        num= varargin{2};
        amax=varargin{3};
        wmax=varargin{4};
        param=varargin{5};
        bees=zeros(scouts,param*num+1);
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

