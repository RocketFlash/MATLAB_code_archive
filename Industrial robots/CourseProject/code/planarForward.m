%function calculates forward kinematics for general n-DOF
%planar robot
%returns x,y coordinates of EE
%input:
%Q   - vector of robot configuration 
%      Q = [q11,q12, ... q1n]
%          [q21,q22, ... q2n]
%          [... ...  ... ...]
%          [qm1,qm2, ... qmn]
%       where m - number of experiments
%             n - number of joints
%Pi  - vector of geometric parameters of the robot 
%      Pi = [q1,l1,q2,l2, ... qn,ln]
%dPi - vector of geometric errors 
%      dPi = [dq1,dl1,dq2,dl2, ... dqn,dln]
%plt - visualization variable (0 - don't plot; 1 - plot)
%output:
%P - matrix of coordinates P(i) = [x(i),y(i)]';
function varargout = planarForward(varargin)

if nargin == 4
   Q =  varargin{1};
   Pi = varargin{2};
   dPi = varargin{3};
   plt = varargin{4};
elseif nargin == 3
   Q =  varargin{1};
   Pi = varargin{2};
   dPi = zeros(1,length(Pi));
   plt = varargin{3};
elseif nargin == 2
   Q =  varargin{1};
   Pi = varargin{2};
   dPi = zeros(1,length(Pi));
   plt = 0;
end

numLinks = size(Q,2);
numExp = size(Q,1);
xs = zeros(numExp,numLinks+1);
ys = zeros(numExp,numLinks+1);
P = zeros(numExp,1);

for j = 1:numExp
    x=0;
    y=0;
    DT = cumsum(Q(j,:)+Pi(1:numLinks)+dPi(1:numLinks));
    for i = 1:numLinks
       x = x + (Pi(i+numLinks)+dPi(i+numLinks))*cos(DT(i));
       y = y + (Pi(i+numLinks)+dPi(i+numLinks))*sin(DT(i));
       xs(j,i+1) = x; 
       ys(j,i+1) = y;
    end
    P(2*j-1:2*j) = [x;y];
end

if plt
    hold on
    for z = 1:numExp
        plot(xs(z,:),ys(z,:),'r','LineWidth',2,'Marker','o')
        str = '';
        for k = 1:numLinks
            str = strcat(str,'Q',num2str(k),'=',num2str(rad2deg(Q(z,k))),'\n');
        end
        str = sprintf(str);
        text(P(2*z-1),P(2*z),str)
    end
    grid on
    a = sum(abs(Pi(length(numLinks)+1:end)));
    xlim([-a,a]);
    ylim([-a,a]);
    xlabel('X(m)','FontSize',12);
    ylabel('Y(m)','FontSize',12);
    title('Forward Kinematics visualization');
end

if nargout==1
    varargout{1} = P;
elseif nargout==2
    varargout{1} = xs;
    varargout{2} = ys;
elseif nargout==3
    varargout{1} = P;
    varargout{2} = xs;
    varargout{3} = ys;
end
end

