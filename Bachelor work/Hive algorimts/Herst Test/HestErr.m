function [MNKerr, Hiveerr, Beeerr]=HestErr(MNK,Hive,Bee,right)

MNKerr=errorcount(MNK,right);
Hiveerr=errorcount(Hive,right);
Beeerr=errorcount(Bee,right);

end