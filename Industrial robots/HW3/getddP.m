function ddP = getddP(Q,dQ,ddQ,L)
J = jacob(Q,L);
ddP = J*ddQ + jacob2(Q,dQ,L)*dQ;

end