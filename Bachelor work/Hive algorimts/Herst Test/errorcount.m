function err = errorcount(A,B)
err=0;
for i=1:length(A)
err=err+abs(abs(A(i))-abs(B(i)));
end
err=err/(sum(B));
end

