function bee = inrange(varargin)
switch nargin
    case 4
        b=varargin{1};
        astep=varargin{2};
        wstep=varargin{3};
        param=varargin{4};
        sstep=0;
    case 5
        b=varargin{1};
        astep=varargin{2};
        wstep=varargin{3};
        sstep=varargin{4};
        param=varargin{5};
end
if param==2
  a=b(1:2:length(b)-1);
  w=b(2:2:length(b)-1);
  for i=1:length(a)
      a(i)=a(i)+randsrc*rand*astep;
      w(i)=w(i)+randsrc*rand*wstep;
  end
  bee(1:2:length(b)-1)=a;
  bee(2:2:length(b)-1)=w;
else
  a=b(1:3:length(b)-1);
  w=b(2:3:length(b)-1);
  s=b(3:3:length(b)-1);
  for i=1:length(a)
      a(i)=a(i)+randsrc*rand*astep;
      w(i)=w(i)+randsrc*rand*wstep;
      s(i)=s(i)+randsrc*rand*sstep;
  end
  bee(1:3:length(b)-1)=a;
  bee(2:3:length(b)-1)=w;
  bee(3:3:length(b)-1)=s;
end

end

