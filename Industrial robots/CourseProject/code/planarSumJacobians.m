%function information matrix
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
%total - information matrix
%      total = m*m matrix

function out = planarSumJacobians(Q,Pi)
    k = (size(Pi,2)/2);
    m = length(Q)/k;
    Jm = zeros(2,2*k,m);
    for i = 1:m
        QQ = cumsum(Q((i-1)*k+1:i*k)+Pi(1:k));

        ss = sin(QQ);
        cs = cos(QQ);
        Jxq = -(Pi(length(Pi)/2+1:end)).*ss;
        Jyq =  (Pi(length(Pi)/2+1:end)).*cs;
        Jxl = cs;
        Jyl = ss;

        J = [Jxq,Jxl;Jyq,Jyl];
        Jm(:,:,i) = J; 
    end
    
    total = zeros(size(Jm,2),size(Jm,2));
    
    for i = 1:size(Jm,3)
        J = squeeze(Jm(:,:,i));
        total = total + J'*J;
    end
    
    out = -det(total);
end

