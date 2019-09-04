% Author: Popov Dmitry & Vladislav Berezhnoy
% Advanced Robotic Manipulation
% Homework 1
%
% Implements inverse kinematics
%
% Using:
% HOWTO(x,y,plot);
% Input: x,y - desired EE position , plot - if true than draw robot in plot
% Output: Q - 4x4 matrix with joints angles in rad


function [Q] = HOWTO(x,y,plot)
d = 300;
l = 300;
L = 100;
A = -2*l*(x-d/2);
B = -2*y*l;
C = (x-d/2)^2+y^2+l^2-L^2;



e = -2*l*(x+d/2);
f = (x+d/2)^2+y^2+l^2-L^2;


q11 = 2*atan((-B+sqrt(B^2-(C^2-A^2)))/(C-A));
q12 = 2*atan((-B-sqrt(B^2-(C^2-A^2)))/(C-A));
q22 = 2*atan((-B+sqrt(B^2-(f^2-e^2)))/(f-e));
q21 = 2*atan((-B-sqrt(B^2-(f^2-e^2)))/(f-e));

q3 = 2*pi-(pi-q12)-acos((L^2+l^2-abs(y^2+(d/2-x)^2))/(2*L*l));
q4 = -pi+q22+acos((L^2+l^2-abs(y^2+(-d/2-x)^2))/(2*L*l));

if plot
    subplot(2,2,1)
    axis equal
    grid on
    line([d/2 l*cos(q12)+d/2],[0 l*sin(q12)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([-d/2 l*cos(q22)-d/2],[0 l*sin(q22)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([l*cos(q12)+d/2 l*cos(q12)+d/2+L*cos(q3)],[l*sin(q12) l*sin(q12)+L*sin(q3)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([l*cos(q22)-d/2 l*cos(q22)-d/2+L*cos(q4)],[l*sin(q22) l*sin(q22)+L*sin(q4)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
end
q3 =2*pi-(pi-q12)-acos((L^2+l^2-abs(y^2+(d/2-x)^2))/(2*L*l));
q4 =  pi-acos((L^2+l^2-abs(y^2+(-d/2-x)^2))/(2*L*l))+q21;

Q(1,:)=[q12,q22,q3,q4];
if plot
    subplot(2,2,2)
    axis equal
    grid on
    line([d/2 l*cos(q12)+d/2],[0 l*sin(q12)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([-d/2 l*cos(q21)-d/2],[0 l*sin(q21)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([l*cos(q12)+d/2 l*cos(q12)+d/2+L*cos(q3)],[l*sin(q12) l*sin(q12)+L*sin(q3)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([l*cos(q21)-d/2 l*cos(q21)-d/2+L*cos(q4)],[l*sin(q21) l*sin(q21)+L*sin(q4)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
end
q3 = q11+acos((L^2+l^2-abs(y^2+(d/2-x)^2))/(2*L*l))-pi;
q4 = -pi+q22+acos((L^2+l^2-abs(y^2+(-d/2-x)^2))/(2*L*l));

Q(2,:)=[q12,q21,q3,q4];
if plot
    subplot(2,2,3)
    axis equal
    grid on
    line([d/2 l*cos(q11)+d/2],[0 l*sin(q11)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([-d/2 l*cos(q22)-d/2],[0 l*sin(q22)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([l*cos(q11)+d/2 l*cos(q11)+d/2+L*cos(q3)],[l*sin(q11) l*sin(q11)+L*sin(q3)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([l*cos(q22)-d/2 l*cos(q22)-d/2+L*cos(q4)],[l*sin(q22) l*sin(q22)+L*sin(q4)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
end
q3 = q11+acos((L^2+l^2-abs(y^2+(d/2-x)^2))/(2*L*l))-pi;
q4 =  pi-acos((L^2+l^2-abs(y^2+(-d/2-x)^2))/(2*L*l))+q21;

Q(3,:)=[q11,q22,q3,q4];
if plot
    subplot(2,2,4)
    axis equal
    grid on
    line([d/2 l*cos(q11)+d/2],[0 l*sin(q11)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([-d/2 l*cos(q21)-d/2],[0 l*sin(q21)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([l*cos(q11)+d/2 l*cos(q11)+d/2+L*cos(q3)],[l*sin(q11) l*sin(q11)+L*sin(q3)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
    line([l*cos(q21)-d/2 l*cos(q21)-d/2+L*cos(q4)],[l*sin(q21) l*sin(q21)+L*sin(q4)],'LineWidth',8,'Color','r','Marker','o','MarkerSize',10);
end

Q(4,:)=[q11,q21,q3,q4];
end