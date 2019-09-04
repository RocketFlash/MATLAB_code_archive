%function returns Pi - calibrated geometric parameters vector  
%Q   - vector of robot configuration 
%      Q = [q11,q12, ... q1n]
%          [q21,q22, ... q2n]
%          [... ...  ... ...]
%          [qm1,qm2, ... qmn]
%       where m - number of experiments
%             n - number of joints
%Pi  - vector of geometric parameters of the robot 
%      Pi = [q1,q2,..qm,l1,l2, ... qm,lm]
%P   - experimental data P(i) = [x(i) y(i)]'
%output:
%out - vector of calibrarted geometrical parameters
%      out = [q1,q2,..qm,l1,l2, ... qm,lm]
function out = planarCalibration(P,Q,Pi,iter)

for i = 1:iter
    Ja = planarJacobian(Q,Pi);
    P0 = planarForward(Q,Pi);
    dP = P - P0;
    dPi = (((Ja'*Ja)^(-1))*Ja'*dP)';
    Pi = Pi + dPi;
    Pi(1:length(Pi)/2) = rem(Pi(1:length(Pi)/2),2*pi);
    Pi(length(Pi)/2+1:end) = abs(Pi(length(Pi)/2+1:end));
end

out = Pi;

end

