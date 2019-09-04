function c = optimal_conf()
a = [-170 -90 90 170]*pi/180;
x = [-70 -35 35 70]*pi/180;
b = [-150 -30]*pi/180;
phi = [-120 -60]*pi/180;
y = -90*pi/180;
w = -60*pi/180;
s = -30*pi/180;

upLimit=[170 120 170 120 170 120 175];
lowLimit=[-170 -120 -170 -120 -170 -120 -175];
% upLimit = upLimit*pi/180;
% lowLimit = lowLimit*pi/180;

c1 = [a(1) x(1) b(1) phi(1)     y   w                     s];
c2 = [a(1) x(2) b(1) phi(1)+pi  y   w+pi                  s];
c3 = [a(1) x(3) b(1) phi(2)     y   w+phi(1)-phi(2)       s];
c4 = [a(1) x(4) b(1) phi(2)+pi  y   w+phi(1)-phi(2)+pi    s];

c5 = [a(2) x(1) b(1)+pi phi(1)     y   w                     s+pi];
c6 = [a(2) x(2) b(1)+pi phi(1)+pi  y   w+pi                  s+pi];
c7 = [a(2) x(3) b(1)+pi phi(2)     y   w+phi(1)-phi(2)       s+pi];
c8 = [a(2) x(4) b(1)+pi phi(2)+pi  y   w+phi(1)-phi(2)+pi    s+pi];

c9  = [a(3) x(1) b(2) phi(1)     y+pi   w                     s+b(1)-b(2)];
c10 = [a(3) x(2) b(2) phi(1)+pi  y+pi   w+pi                  s+b(1)-b(2)];
c11 = [a(3) x(3) b(2) phi(2)     y+pi   w+phi(1)-phi(2)       s+b(1)-b(2)];
c12 = [a(3) x(4) b(2) phi(2)+pi  y+pi   w+phi(1)-phi(2)+pi    s+b(1)-b(2)];

c13 = [a(4) x(1) b(2)+pi phi(1)     y+pi   w                     s+b(1)-b(2)+pi];
c14 = [a(4) x(2) b(2)+pi phi(1)+pi  y+pi   w+pi                  s+b(1)-b(2)+pi];
c15 = [a(4) x(3) b(2)+pi phi(2)     y+pi   w+phi(1)-phi(2)       s+b(1)-b(2)+pi];
c16 = [a(4) x(4) b(2)+pi phi(2)+pi  y+pi   w+phi(1)-phi(2)+pi    s+b(1)-b(2)+pi];
c = [c1; c2; c3;c4;c5;c6;c7;c8;c9;c10;c11;c12;c13;c14;c15;c16];
end