function values = calculateSinCos(Q,numlinks)

cs2 = sum(cos(Q(2:numlinks:end)));
ss2 = sum(sin(Q(2:numlinks:end)));
if numlinks<=2
    values = [cs2,ss2];
    dispVal(values);
    return
end

cs3 = sum(cos(Q(3:numlinks:end)));
ss3 = sum(sin(Q(3:numlinks:end)));
cs4 = sum(cos(Q(4:numlinks:end)));
ss4 = sum(sin(Q(4:numlinks:end)));
if numlinks==3
    values = [cs2,ss2,cs3,ss3,cs4,ss4];
    dispVal(values);
    return
end

cs23 = sum(cos(Q(2:numlinks:end)+Q(3:numlinks:end)));
ss23 = sum(sin(Q(2:numlinks:end)+Q(3:numlinks:end)));
cs34 = sum(cos(Q(4:numlinks:end)+Q(3:numlinks:end)));
ss34 = sum(sin(Q(4:numlinks:end)+Q(3:numlinks:end)));
cs24 = sum(cos(Q(2:numlinks:end)+Q(3:numlinks:end)+Q(4:numlinks:end)));
ss24 = sum(sin(Q(2:numlinks:end)+Q(3:numlinks:end)+Q(4:numlinks:end)));

if numlinks==4
    values = [cs2,ss2,cs3,ss3,cs4,ss4,cs23,ss23,cs34,ss34,cs24,ss24];
    dispVal(values);
    return
end

end

function dispVal(v)
    for i = 1:length(v)
        disp(strcat('v',num2str(i),': ',num2str(v(i))));
    end
end
