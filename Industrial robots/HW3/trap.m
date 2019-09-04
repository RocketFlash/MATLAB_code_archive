%Creates apropriate trapeze according to constrains
function varargout = trap(varargin)
%
%^  ____________     _Vmax
%| /  |      |  \  
%|amax.______.___.
%    t1     t2  tf
% disc - discretization time
% pl - true if you want to plot the graphics

if nargin == 4
    dq = varargin{1};
    amax = varargin{2};
    Vmax = varargin{3};
    disc = varargin{4};
    pl = 0;
elseif nargin ==5
    dq = varargin{1};
    amax = varargin{2};
    Vmax = varargin{3};
    disc = varargin{4};
    pl = varargin{5};
elseif nargin == 3
    dq = varargin{1};
    t = varargin{2};
    pl = varargin{3};
    Vnew = dq/t(2);
    anew = Vnew/t(1);
    varargout{1} = anew;
    varargout{2} = Vnew;
    
    if pl
        hold on
        for i = 1:length(anew)
            plot([0,t(1)],[0,Vnew(i)],'Color',[0.3*i,1-0.3*i,0.8-0.1*i]);
            plot([t(1),t(2)],[Vnew(i),Vnew(i)],'Color',[0.3*i,1-0.3*i,0.8-0.1*i]);
            plot([t(2),t(3)],[Vnew(i),0],'Color',[0.3*i,1-0.3*i,0.8-0.1*i]);
        end
    end
    return
end


if dq<0
    Vmax = -Vmax;
    amax = -amax;
end

t1 = Vmax/amax;
t2 = (dq - t1*Vmax)/Vmax + t1;
tf = t2 + t1;

if pl
    hold on
    plot([0,t1],[0,Vmax],'r');
    plot([t1,t2],[Vmax,Vmax],'r');
    plot([t2,tf],[Vmax,0],'r');
end

%rounding t1
if ( t1 - fix(t1*disc)/disc > 0.0) 
    t1 = (fix(t1*disc)+1)/disc;
else
    t1 = fix(t1*disc)/disc;
end

%rounding t2
if ( t2 - fix(t2*disc)/disc > 0.0) 
    t2 = (fix(t2*disc)+1)/disc;
else
    t2 = fix(t2*disc)/disc;
end

tf = t2+t1;

Vnew = dq/t2;
anew = Vnew/t1;

%recalculate all parameters if t1 >= t2 (triangle case)
%      ^       _Vmax
%    / | \
%   /  |  \
%  /   |   \
% /    |    \
% amax_._____.
%   (t1,t2)   tf
if t1>=t2
    t1 = sqrt(dq/amax);
    if ( t1 - fix(t1*disc)/disc > 0.0) 
        t1 = (fix(t1*disc)+1)/disc;
    else
        t1 = fix(t1*disc)/disc;
    end
    t2 = t1;
    tf = 2*t1;
    Vnew = dq/t1;
    anew = Vnew/t1;
end

varargout{1}=t1;
varargout{2}=t2;
varargout{3}=tf;
varargout{4}=anew;
varargout{5}=Vnew;
if pl
    plot([0,t1],[0,Vnew],'--b');
    plot([t1,t2],[Vnew,Vnew],'--b');
    plot([t2,tf],[Vnew,0],'--b');
    grid on
    legend('analytical','according discretization');
end

end

