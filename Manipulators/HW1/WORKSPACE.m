function res = WORKSPACE()

L0=300;
L1=300;
L2=100;

A1 = [0,0];
A2 = [L0,0];
% A1 is the origin, A1-A2 goes in the X direction

%L2 is lesser than L1 ->
% The workspace of each kinematic chain is the ring with
% R=L1+L2
% r=L1-L2
% and the center of this circles are A1 and A2 points
% distance between A1 and A2 is 300, L0 > L2+L2    ->
% this 2 rings have 2 intersections
%
% each intersection is the reachable workspace restricted with 4 arcs.
% 
n=100;
% n is the number of points on each arc

R=L1+L2;
r=L1-L2;

R_alpha_from = acos((R^2+L0^2-R^2)/(2*L0*R));
R_alpha_to = acos((R^2+L0^2-r^2)/(2*L0*R));
r_alpha_from = acos((r^2+L0^2-R^2)/(2*L0*r));
r_alpha_to = acos((r^2+L0^2-r^2)/(2*L0*r));
% angles came from the solution of 2-circles system of equation

hold on;

% ARCPLOT(0,2*pi,n,R,A1,'yellow');
% ARCPLOT(0,2*pi,n,r,A1,'yellow');
% ARCPLOT(0,2*pi,n,R,A2,'yellow');
% ARCPLOT(0,2*pi,n,r,A2,'yellow');
%plotting all circles
ARCPLOT(0,2*pi,n,R,A1,'k');
ARCPLOT(0,2*pi,n,r,A1,'k');
ARCPLOT(0,2*pi,n,R,A2,'k');
ARCPLOT(0,2*pi,n,r,A2,'k');

ARCPLOT(R_alpha_from,R_alpha_to,n,R,A1,'red');
ARCPLOT(r_alpha_from,r_alpha_to,n,r,A1,'blue');
ARCPLOT(-R_alpha_from,-R_alpha_to,n,R,A1,'red');
ARCPLOT(-r_alpha_from,-r_alpha_to,n,r,A1,'blue');
ARCPLOT(pi-R_alpha_from,pi-R_alpha_to,n,R,A2,'red');
ARCPLOT(pi-r_alpha_from,pi-r_alpha_to,n,r,A2,'blue');
ARCPLOT(pi+R_alpha_from,pi+R_alpha_to,n,R,A2,'red');
ARCPLOT(pi+r_alpha_from,pi+r_alpha_to,n,r,A2,'blue');
%plotting workspace area (intersections)

hold off;

end