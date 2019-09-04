clear all
close all

%links length
L = [0.1,0.1,0.1];
%maximal acceleration
amax = 1;
%maximal velocity
Vmax = 1;
%discretization frequency
disc = 100;
%vector of constraints
C = [amax,Vmax,disc];

%key points of trajectory in cartesian space 
%(x,y - position coordinates and phi - orientation)
X = [-0.05,-0.05,0.05,0.05,-0.05];
Y = [-0.05,0.05,0.05,-0.05,-0.05];
PHI = [pi,pi/2,pi/2,0,pi/2];

%calculate inverse kinematics for each key point of trajectory 
QQ = inverse(X,Y,PHI,L);
%select one of two solutions of inverse kinematics {1,2}
invSol = 1;

%form convenient matrix for calculations
Q=zeros(length(X),3);
for i = 1:length(X)
    Q(i,1:3) = QQ(invSol,(3*i-2):3*i);
end

%return accelerations, velocities and time points using
%trapezoids technique
[A,V,T]=path(Q,C,false);
%use junctions
%function returns points after junction as well as before 
[J,Jnew,t]=junction(V,T,disc,5);

%plot velocity trapezoids before and after junction
figure;
plot(t,J(1,:),'.',t,J(2,:),'.',t,J(3,:),'.',t,Jnew(1,:),'--',t,Jnew(2,:),'--',t,Jnew(3,:),'--','LineWidth',1);
legend('joint1 before','joint2 before','joint3 before','joint1 after','joint5 after','joint6 after');
title('Velocities before and after junction','FontSize',16)
xlabel('time (sec)','FontSize',14);
ylabel('velocity (m/s)','FontSize',14);
grid on

%get descrete positions,velocities and accelerations points
QW = PVA(Jnew,disc);

%inverse kinematics for the first point
ss = inverse(X(1),Y(1),PHI(1),L)';
%get descrete trajectory points
[x,y,phi] = forward(QW(1:3,:)+repmat(ss(:,1),1,size(QW,2)),L);

%position graph in joint space over time
figure;
plot(t,QW(1,:),'r',t,QW(2,:),'g',t,QW(3,:),'b','LineWidth',1);
xlabel('time (sec)','FontSize',14);
ylabel('Joint position (rad)','FontSize',14);
title('Position graph in joint space over time','FontSize',16)
legend('joint1','joint2','joint3');
grid on

%acceleration graph in joint space over time
figure;
plot(t,QW(7,:),'.r',t,QW(8,:),'.g',t,QW(9,:),'.b','LineWidth',1);
xlabel('time (sec)','FontSize',14);
ylabel('Joint accelerations (rad/sec^2)','FontSize',14);
title('Acceleration graph in joint space over time','FontSize',16)
legend('joint1','joint2','joint3');
grid on

%plot decrete trajectory points
figure;
plot(x,y,'.r',X,Y,'ob');
xlabel('X (m)','FontSize',14);
ylabel('Y (m)','FontSize',14);
title('Trajectory in cartesian space','FontSize',16)
legend('robot trajectory','key points');
grid on