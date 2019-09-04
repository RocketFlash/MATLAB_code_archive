function S = SQ(Yexp,Y)
S=sum((Yexp-Y').^2)/length(Y);
end

