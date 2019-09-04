%forward kinematics for RRR planar robot
function [x,y,phi] = forward(Q,L)
x = cos(Q(1,:))*L(1) + cos(Q(1,:)+Q(2,:))*L(2) + cos(Q(1,:)+Q(2,:)+Q(3,:))*L(3);
y = sin(Q(1,:))*L(1) + sin(Q(1,:)+Q(2,:))*L(2) + sin(Q(1,:)+Q(2,:)+Q(3,:))*L(3);
phi = Q(1,:) + Q(2,:) + Q(3,:);
end

