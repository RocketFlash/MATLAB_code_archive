%function returns Jacobian of 7DOF KUKA iiwa robot
%input:
%Q   - vector of robot configuration 
%      Q = [q11,q12, ... q1n]
%          [q21,q22, ... q2n]
%          [... ...  ... ...]
%          [qm1,qm2, ... qmn]
%       where m - number of experiments
%             n - number of joints
%Pi  - vector of geometric parameters of the robot 
%      Pi = [l1,l2, ... ln]
%Tbase - transformation matrix of base
%Ttool - transformation matrix of tool
%output:
%T   - transformation matrix of EE
function T = ForwardKinematics_7DOF(Q,Pi,Tbase,Ttool)
T = Tbase*Rz(Q(1)+Pi(1))*...
    Ry(Q(2)+Pi(2))*Tz(Pi(8))*...
    Rz(Q(3)+Pi(3))*...
    Ry(Q(4)+Pi(4))*Tz(Pi(9))*...
    Rz(Q(5)+Pi(5))*...
    Ry(Q(6)+Pi(6))*...
    Rz(Q(7)+Pi(7))*Ttool; 
end