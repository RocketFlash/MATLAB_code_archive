%inverse kinematics for RRR planar robot
function Q = inverse(x,y,phi,L)
n = length(x);
Q=zeros(2,3*n);
for i = 0:n-1
    xb = x(i+1)-cos(phi(i+1))*L(3);
    yb = y(i+1)-sin(phi(i+1))*L(3);
    ln = sqrt(xb^2+yb^2);
    cosz = (ln^2-L(1)^2-L(2)^2)/(2*L(1)*L(2));
    cz1 = sqrt(1-cosz^2);
    cz2 = cosz;
    Q(1,3*i+2) = atan2(cz1,cz2); 
    Q(2,3*i+2) = atan2(-cz1,cz2);

    Q(1,3*i+1) = atan2(yb,xb)-acos((ln^2+L(1)^2-L(2)^2)/(2*ln*L(1)));
    Q(2,3*i+1) = atan2(yb,xb)+acos((ln^2+L(1)^2-L(2)^2)/(2*ln*L(1)));

    Q(1,3*i+3) = phi(i+1) - Q(1,3*i+1) -Q(1,3*i+2);
    Q(2,3*i+3) = phi(i+1) - Q(2,3*i+1) -Q(2,3*i+2);
end

end

