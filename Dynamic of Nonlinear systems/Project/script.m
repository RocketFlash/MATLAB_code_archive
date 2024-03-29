%translation vector from frame to frame
robot.L(1,:) = [5 0]; 
robot.L(2,:) = [4 0];
robot.L(3,:) = [3 0];

%translation to the COM of the link from the end 
robot.COM(1,:) = [-3 0 0];
robot.COM(2,:) = [-2.2 0 0];
robot.COM(3,:) = [-1.6 0 0];

%restrictions for the linear and angular speed
robot.VCartEE = 2;
% robot.VJoint(1) = 1;
% robot.VJoint(2) = 1;
% robot.VJoint(3) = 1;
%here we focused only on the Cartesian velocity constrains

%200 Hz
robot.Freq = 200;

%trajectory of the robot will be cyclic in this triangle
p = [4,4, 0;
    5,6, pi/2;
    2,3, pi;
    4,4, 0];
%plotting trajectory
myplot(p);

X = trajectory(p,robot);

Q = IK(X,robot);
