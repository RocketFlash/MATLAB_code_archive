function [a1min,a2min,w1min,w2min]= MNK(Y0,s1,s2,afid,w1ub,w2ub,wfid)
S=0;
Smin=1000000000000;
aub=max(Y0);
w1min=0;
w2min=0;
a1min=0;
a2min=0;
for a1=8:afid:aub
for a2=20:afid:aub
for w1=17:wfid:19
for w2=23:wfid:27
    
   if a1+a2<=aub
    S=SumSquaresFunction(Y0,a1,a2,w1,w2,s1,s2);
    S=abs(S);
    if S<Smin
    Smin=S;
    w1min=w1;
    w2min=w2;
    a1min=a1;
    a2min=a2;
    end
   end 
end
end
end
end

end

