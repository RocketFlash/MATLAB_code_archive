function tau = direct_dynamics(q,dq,ddq)

m1 = 3;
m2 = 2;
l1 = 5;
l2 = 4;
I1 = 2.5;
I2 = 1.5;
lc1 = 2.5;
lc2 = 2;
g = 9.8;
tau = zeros(2,1);
tau(1) = (I1 + I2 + m1*lc1^2 + m2*(l1^2+lc2^2+2*l1*lc2*cos(q(2))))*ddq(1) + ...
         (m2*(lc2^2+l1*lc2*cos(q(2))) + I2)*ddq(2) - ...
         m2*l1*lc2*sin(q(2))*(2*dq(1)*dq(2)+ dq(2)^2) + ...
         m1*g*lc1*cos(q(1)) + m2*g*(l1*cos(q(1)) + lc2*cos(q(1)+q(2)));
tau(2) = (I2 + m2*(lc2^2 + l1*lc2*cos(q(2))))*ddq(1) +...
         (m2*lc2^2 + I2)*ddq(2) + m2*l1*lc2*sin(q(2))*dq(1)^2 +...
         m2*g*lc2*cos(q(1)+q(2));

end

