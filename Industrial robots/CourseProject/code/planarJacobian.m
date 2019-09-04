%function calculates Jacobian matrix for general n-DOF planar robot
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
%output:
%Jtot - total jacobian matrix for m number of experiments
%      Jtot = [Jxq1,Jyq1,Jxq2,Jyq2, ... Jxqm,Jyqm]
%             [Jxl1,Jyl1,Jxl2,Jyl2, ... Jxlm,Jylm]
%Jm - 3d array of jacobians
function varargout = planarJacobian(Q,Pi)
Jtot = zeros(2*size(Q,1),2*size(Q,2));
Jm = zeros(2,2*size(Q,2),size(Q,1));
for i = 1:size(Q,1)
    QQ = cumsum(Q(i,:)+Pi(1:length(Q(i,:))));
    
    ss = sin(QQ);
    cs = cos(QQ);
    Jxq = -(Pi(length(Q(i,:))+1:end)).*ss;
    Jyq =  (Pi(length(Q(i,:))+1:end)).*cs;
    Jxl = cs;
    Jyl = ss;
    
    J = [Jxq,Jxl;Jyq,Jyl];
    Jtot(2*i-1:2*i,:) = J;
    Jm(:,:,i) = J; 
end

if nargin == 1
    varargout{1} = Jtot;
elseif nargin == 2
    varargout{1} = Jtot;
    varargout{2} = Jm;
end
end

