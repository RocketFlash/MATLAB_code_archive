%returns transformation matrix of EE
function Ttot = transf(PI,Q)

T1 = rottx(PI(1));
T2 = rotty(PI(2));
T3 = translz(PI(3)+Q(1));
T4 = rottz(PI(4));
% T5 = rotty(PI(5));
T6 = translx(PI(5)+Q(2));
T7 = rottx(PI(6));
T8 = rottz(PI(7));
T9 = transly(PI(8)+Q(3));
T10 = rottx(PI(9));
% T11 = rotty(PI(11));
T12 = rottz(PI(10));
T13 = rotty(Q(4));
T14 = rottx(PI(11));
T15 = rotty(PI(12));
T16 = rottz(PI(13));
T17 = rottx(Q(5));
T18 = translz(PI(14));

Ttot = T1*T2*T3*T4*T6*T7*T8*T9*T10*T12*T13*T14*T15*T16*T17*T18;
end

