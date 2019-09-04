function QQ = moves(P0,Pf,D,L,C)
step = (Pf-P0)/D;
a = inverse(P0);
b = inverse(P0);

[~,Vnews,T] = move((i-1)*step+inverse(P0(1),P0(2),P0(3),L),inverse(P0(1),P0(2),P0(3),L)+i*step,C);
[J,~,~] = junction(Vnews,T,C(3),0);

SS = zeros(3,3*size(J,2));
SS(:,1:size(J,2)) = J;
for i = 2:D
[~,Vnews,T] = move((i-1)*step+inverse(P0(1),P0(2),P0(3),L),inverse(P0(1),P0(2),P0(3),L)+i*step,C);
[J,~,~] = junction(Vnews,T,C(3),0);
SS(:,size(J,2)*i+1:size(J,2)*i) = J;
end

QQ = PVA(SS,C(3)); 

end

