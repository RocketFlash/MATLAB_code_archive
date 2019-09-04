function [out,total] = sumJacobians_7DOF(varargin)
    if nargin == 2
        Q = varargin{1};
        Pi = varargin{2};
        krit = 'D';
    elseif nargin == 3
        Q = varargin{1};
        Pi = varargin{2};
        krit = varargin{3};
    end
    total = zeros(7,7);
    m = length(Q(:))/7;
    for i = 1:m
        J = Jacobian_7DOF(Q((i-1)*7+1:i*7),Pi,eye(4),eye(4));
%         J = J(1:3,:);
        total = total + J'*J;
    end
    if krit=='D'
        out = -det(total);
    elseif krit =='A'
        out = trace(total^(-1));   
    else 
        out = 0;
    end
end

