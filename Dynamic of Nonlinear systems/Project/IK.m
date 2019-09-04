function Q = IK(X,robot)
Q = zeros(size(X));
    for i=1:size(X,1)
        xx = X(i,1:2);
        L1 = norm(robot.L(1,:));
        L2 = norm(robot.L(2,:));
        d = norm(xx);
        q2 = pi - acos((d^2 - L1^2 + L2^2)/(-2*L1*L2));
        %minus corresponds to elbow down conf
        q1 = atan2(p2(2),p2(1)) - acos((d^2+L1^2-L2^2)/(2*d*L1));
        % q1+q2+q3=theta
        Q(i,1:2) = [q1 q2];
    end
end