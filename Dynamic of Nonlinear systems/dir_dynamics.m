% function dir_dynamics()
syms q1 q2 q3 q1d q2d q3d q1dd q2dd q3dd

u = [1;0;0.1];
q = [q1;q2;q3];
qd = [q1d;q2d;q3d];
qdd = [q1dd;q2dd;q3dd];

g = 9.8;

m1 = 6.4;
m2 = 2.1;
m3 = 2.13;

l1 = 0.3;
l2 = 0.1;
l3 = 0.1;

r1 = 0.12;
r2 = 0.04;
r3 = 0.04;

p1 = [q1-r1;...
          0;...
          0];
      
p2 = [q1+(l2-r2)*cos(q2);...
        (l2-r2)* sin(q2);...
                      0];
    
p3 = [q1+l2*cos(q2)+ (l3-r3)*cos(q3);...
        l2*sin(q2) + (l3-r3)*sin(q3);...
                                   0];

v1 = [q1d;...
        0;...
        0];
    
v2 = [q1d - (l2-r2)*sin(q2)*q2d;...
      l2*cos(q2)*q2d + (l3-r3)*cos(q3)*q3d;...
      0];
  
v3 = [q1d - l2*sin(q2)*q2d - (l2-r3)*sin(q2 + q3)*q3d;...
            l2*cos(q2)*q2d + (l3-r3)*cos(q2 + q3)*q3d;...
                                               0];

w1 = [0;0;0];
w2 = [0;0;q2d];
w3 = [0;0;q2d+q3d];

% I1 = m1*r1^2;
% I2 = m2*r2^2;
% I3 = m3*r3^2;


I1 = 0.008;
I2 = 0.0027;
I3 = 0.0027;



T1 = 1/2*(m1*(v1.'*v1) + I1 * (w1.'* w1));
T2 = 1/2*(m2*(v2.'*v2) + I2 * (w2.'* w2));
T3 = 1/2*(m3*(v3.'*v3) + I3 * (w3.'* w3));

T = T1 + T2 + T3;

U1 =0;
U2 =-m2*g*((l2-r2)*sin(q2));
U3 =-m3*g*((l2*sin(q2) + (l3-r3)*sin(q2 + q3)));

U = U1 + U2 + U3;

coeff = collect(T,[q1d q2d q3d]);
[cx,tx] = coeffs(coeff,[q1d q2d q3d]);

B = sym('b', [3 3]);
B(1,1) = cx(1);
B(2,2) = cx(4);
B(3,3) = cx(6);
B(1,2) = cx(2)/2;
B(1,3) = cx(3)/2;
B(2,3) = cx(5)/2;
B(2,1) = B(1,2);
B(3,1) = B(1,3);
B(3,2) = B(2,3);

b1 = B(:,1);
b2 = B(:,2);
b3 = B(:,3);

a1 = [diff(b1,q1d) diff(b1,q2d) diff(b1,q3d)];
a2 = [diff(b2,q1d) diff(b2,q2d) diff(b2,q3d)];
a3 = [diff(b3,q1d) diff(b3,q2d) diff(b3,q3d)];

C1 = 1/2*(a1 + a1' - diff(B,q1d));
C2 = 1/2*(a2 + a2' - diff(B,q2d));
C3 = 1/2*(a3 + a3' - diff(B,q3d));

c1 = qd'*C1*qd;
c2 = qd'*C2*qd;
c3 = qd'*C3*qd;

c = [c1;c2;c3];

dU1 = diff(U,q1);
dU2 = diff(U,q2);
dU3 = diff(U,q3);

dU = [dU1; dU2; dU3];

qdd = B^(-1)*(u - (c+dU));
syms z1(t) z2(t) z3(t)
z1d = diff(z1);
z2d = diff(z2);
z3d = diff(z3);


z1dd = diff(z1d);
z2dd = diff(z2d);
z3dd = diff(z3d);

zdd = [z1dd z2dd z3dd];

B = subs(B,[q1 q2 q3 q1d q2d q3d q1dd q2dd q3dd],[z1 z2 z3 z1d z2d z3d z1dd z2dd z3dd]);
c = subs(c,[q1 q2 q3 q1d q2d q3d q1dd q2dd q3dd],[z1 z2 z3 z1d z2d z3d z1dd z2dd z3dd]);
dU = subs(dU,[q1 q2 q3 q1d q2d q3d q1dd q2dd q3dd],[z1 z2 z3 z1d z2d z3d z1dd z2dd z3dd]);

y_solve = dsolve(qdd - simplify(B^(-1))*(u - (c+dU)));



