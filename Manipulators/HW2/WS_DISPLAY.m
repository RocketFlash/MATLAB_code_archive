% Author: Popov Dmitry & Yagfarov Rauf & Getmanskiy Andrey
% Innopolis University
% Advanced Robotic Manipulation
% Homework 2
%
% Draw robot singularities
%
% Using:
% WS_DISPLAY;
% Input: none
% Output: none

%function WS_DISPLAY

% robot parameters
d=300;
l=300;
L=100;
x = -200:5:200;
y = -400:10:400;
z1 = zeros(length(x),length(y));
z2 = zeros(length(x),length(y));
z3 = zeros(length(x),length(y));
z4 = zeros(length(x),length(y));


for i = 1:length(x)
    for j = 1:length(y)
        
        Q=HOWTO(x(i),y(j),false); %IK
        
            
        % draw WS for 4 posible robot configurations
        
        if isreal(Q(1,1))&&isreal(Q(1,2))&&isreal(Q(1,3))&&isreal(Q(1,4))...
                &&isfinite(Q(1,1))&&isfinite(Q(1,2))&&isfinite(Q(1,3))&&isfinite(Q(1,4))
            
            Ja=[L*cos(Q(1,3)) L*sin(Q(1,3));L*cos(Q(1,4)) L*sin(Q(1,4))];
            Jb=[l*L*sin(Q(1,1)-Q(1,3)) 0; 0 l*L*sin(Q(1,2)-Q(1,4))];
            z1(i,j) = 1/cond(Jb*inv(Ja));
            
        end
        if isreal(Q(2,1))&&isreal(Q(2,2))&&isreal(Q(2,3))&&isreal(Q(2,4))...
                &&isfinite(Q(2,1))&&isfinite(Q(2,2))&&isfinite(Q(2,3))&&isfinite(Q(2,4))
            Ja=[L*cos(Q(2,3)) L*sin(Q(2,3));L*cos(Q(2,4)) L*sin(Q(2,4))];
            Jb=[l*L*sin(Q(2,1)-Q(2,3)) 0; 0 l*L*sin(Q(2,2)-Q(2,4))];
            z2(i,j) = 1/cond(Jb*inv(Ja));
            
        end
        if isreal(Q(3,1))&&isreal(Q(3,2))&&isreal(Q(3,3))&&isreal(Q(3,4))...
                &&isfinite(Q(3,1))&&isfinite(Q(3,2))&&isfinite(Q(3,3))&&isfinite(Q(3,4))
            Ja=[L*cos(Q(3,3)) L*sin(Q(3,3));L*cos(Q(3,4)) L*sin(Q(3,4))];
            Jb=[l*L*sin(Q(3,1)-Q(3,3)) 0; 0 l*L*sin(Q(3,2)-Q(3,4))];
            z3(i,j) = 1/cond(Jb*inv(Ja));
            
        end
        if isreal(Q(4,1))&&isreal(Q(4,2))&&isreal(Q(4,3))&&isreal(Q(4,4))...
                &&isfinite(Q(4,1))&&isfinite(Q(4,2))&&isfinite(Q(4,3))&&isfinite(Q(4,4))
            Ja=[L*cos(Q(4,3)) L*sin(Q(4,3));L*cos(Q(4,4)) L*sin(Q(4,4))];
            Jb=[l*L*sin(Q(4,1)-Q(4,3)) 0; 0 l*L*sin(Q(4,2)-Q(4,4))];
            z4(i,length(y)-j) = 1/cond(Jb*inv(Ja));
            
        end
    end
    
end

w1=(z1<=10e-2);
w2=(z2<=10e-2);
w3=(z3<=10e-2);
w4=(z4<=10e-2);

figure(1)
subplot(2,2,2)
surf(x,y,double(w1'))
subplot(2,2,3)
surf(x,y,double(w2'))
subplot(2,2,4)
surf(x,y,double(w3'))
subplot(2,2,1)
surf(x,y,double(w4'))

figure(2)
subplot(2,2,2)
surf(x,y,z1')
subplot(2,2,3)
surf(x,y,z2')
subplot(2,2,4)
surf(x,y,z3')
subplot(2,2,1)
surf(x,y,z4')





