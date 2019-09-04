%this function generates appropriate accelerations,velocities and times
%according to the trajectory points

function [A,V,T] = path(varargin)
% input arguments:
% C - constraints: C = [amax,Vmax,disc]
%        teta1 teta2 teta3
%     P1| #     #     #   |
%     P2| #     #     #   |
% Q = P3| #     #     #   |
%     P4| #     #     #   |
%     P5| #     #     #   |
% pl(optional) - if true plots the velocity trapezoids
% where:
% Pi - point in joint space 
% tetai - i joint position in the joint space
% output data:
%               P2-P1 P3-P2 P4-P3 P5-P4
%      joint1 |   #     #     #     #  |
%  A = joint2 |   #     #     #     #  |
%      joint3 |   #     #     #     #  |
%               P2-P1 P3-P2 P4-P3 P5-P4
%      joint1 |   #     #     #     #  |
%  V = joint2 |   #     #     #     #  |
%      joint3 |   #     #     #     #  |
%           P2-P1 P3-P2 P4-P3 P5-P4
%      t0 |   #     #     #     #  |
%  T = t1 |   #     #     #     #  |
%      t2 |   #     #     #     #  |
%      tf |   #     #     #     #  |

if nargin==2
    Q = varargin{1};
    C = varargin{2};
    pl = false;
elseif nargin==3
    Q = varargin{1};
    C = varargin{2};
    pl= varargin{3};
end

n = size(Q,1)-1;
A = zeros(3,n);
V = zeros(3,n);
T = zeros(4,n);
tad = 0;%shift next trapeza according to current

for i=1:n
    [anews,Vnews,Tnews] = move(Q(i,:),Q(i+1,:),C);
    A(:,i) = anews;
    V(:,i) = Vnews;
    T(1,i) = tad;
    T(2:4,i) = Tnews+tad;
    tad = T(4,i);
end

if pl
    plotTrap(A,V,T);
end

end
