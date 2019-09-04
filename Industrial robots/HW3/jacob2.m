function dJ = jacob2 (Q,dQ,L)
%finds tie derivative from Jacobian matrix
dJ = zeros(3,3);
dJ(1,1) = -cos(Q(1))*L(1)*dQ(1)-cos(Q(1)+Q(2))*L(2)*(dQ(2)+dQ(1))-cos(Q(1)+Q(2)+Q(3))*L(3)*(dQ(1)+dQ(2)+dQ(3));
dJ(1,2) = -cos(Q(1)+Q(2))*L(2)*(dQ(2)+dQ(1))-cos(Q(1)+Q(2)+Q(3))*L(3)*(dQ(3)+dQ(2)+dQ(1));
dJ(1,3) = -cos(Q(1)+Q(2)+Q(3))*L(3)*(dQ(3)+dQ(2)+dQ(1));
dJ(2,1) = -sin(Q(1))*L(1)*dQ(1)-sin(Q(1)+Q(2))*L(2)*(dQ(2)+dQ(1))-sin(Q(1)+Q(2)+Q(3))*L(3)*(dQ(3)+dQ(2)+dQ(1));
dJ(2,2) = -sin(Q(1)+Q(2))*L(2)*(dQ(2)+dQ(1))-sin(Q(1)+Q(2)+Q(3))*L(3)*(dQ(3)+dQ(2)+dQ(1));
dJ(2,3) = -sin(Q(1)+Q(2)+Q(3))*L(3)*(dQ(3)+dQ(2)+dQ(1));
dJ(3,1) = 0;
dJ(3,2) = 0;
dJ(3,3) = 0;

end