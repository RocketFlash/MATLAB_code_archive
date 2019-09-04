%this function generate accelerations,velocities and time points 
%to perform synchronous movement
function [anews,Vnews,T] = move(Q0,Qf,C)
%     
%     | # |      | # |
%Q0 = | # | Qf = | # |
%     | # |      | # |
%
% C = [amax,Vmax,disc]
% constraints
amax = C(1);
Vmax = C(2);
disc = C(3);
% the maximum length of the path in the joint space
[dqmax,i] = max(abs(Qf-Q0));
[t1,t2,tf,~,~] = trap(Qf(i)-Q0(i),amax,Vmax,disc);
T = [t1,t2,tf];
[anews,Vnews] = trap((Qf-Q0),T,false);
end

