function [MNKerr, Hiveerr, Beeerr]=HestErr2(MNK,Hive,Bee,right,X,s)
if nargin==4
    MNKerr=errcount(X,MNK,right,s);
    Hiveerr=0;
    Beeerr=0;
else
MNKerr=errcount(X,MNK,right,s);
Hiveerr=errcount(X,Hive,right,s);
Beeerr=errcount(X,Bee,right,s);
end
end