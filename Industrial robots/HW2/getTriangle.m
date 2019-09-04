%Function returns three vectors which correspond to three triangle points
function [v1,v2,v3] = getTriangle(PI,Q,l)
%coordinates of the triangle points in EE frame
r1 = [0,l,0,1];
r2 = [-l*sqrt(3)/2,-l/2,0,1];
r3 = [l*sqrt(3)/2,-l/2,0,1];
%calculate transformation matrix of EE
T = transf(PI,Q);
%triangle points in the world coordinates system
v1 = T*r1';
v2 = T*r2';
v3 = T*r3';
end

