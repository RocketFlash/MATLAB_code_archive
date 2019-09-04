function x = trajectory(p,robot)
% this function creates the trajectory for 3 DOF 2D manipulator with VSA

x = zeros(10000,2);
%ponts generation for each trajectory segment
k=0; % the current time frame
for i=1:size(p,1)-1
    transV = p(i+1,:)-p(i,:);
    n = ceil(norm(transV)/robot.VCartEE*robot.Freq);
    % n is the number of samples for this line tralectory
    temp = 1/n:1/n:1;
    x(k+1:k+n,:) = (transV'*temp)';
    
    k = k + n;
end
x = x(1:k,:);

end