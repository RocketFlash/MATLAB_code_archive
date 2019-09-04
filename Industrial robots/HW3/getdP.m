function dP = getdP (Q,dQ,L)
dP = jacob(Q,L)*dQ;
end