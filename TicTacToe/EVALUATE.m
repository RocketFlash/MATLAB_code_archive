% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function val = EVALUATE (pos)
n=length(pos);
val = zeros(length(pos),length(pos));
for i=1:n
    x_num = sum(pos(i,1:end)==1);
    o_num = sum(pos(i,1:end)==-1);
    if (x_num>0) && (o_num==0)
        val(i,1:end) = val(i,1:end) + pos(i,1:end)*(x_num^2);
    end
    if (o_num>0) && (x_num==0)
        val(i,1:end) = val(i,1:end) + pos(i,1:end)*(o_num^2);
    end
end
%evaluate lines

for i=1:n
    x_num = sum(pos(1:end,i)==1);
    o_num = sum(pos(1:end,i)==-1);
    if (x_num>0) && (o_num==0)
        val(1:end,i) = val(1:end,i) + pos(1:end,i)*(x_num^2);
    end
    if (o_num>0) && (x_num==0)
        val(1:end,i) = val(1:end,i) + pos(1:end,i)*(o_num^2);
    end
end
%evaluate colunms

x_num = sum(diag(pos)==1);
o_num = sum(diag(pos)==-1);
if (x_num>0) && (o_num==0)
    for i=1:n
        val(i,i) = val(i,i) + pos(i,i)*(x_num^2);
    end
end
if (o_num>0) && (x_num==0)
    for i=1:n
        val(i,i) = val(i,i) + pos(i,i)*(o_num^2);
    end
end
%evaluate main diag

x_num = sum(diag(fliplr(pos))==1);
o_num = sum(diag(fliplr(pos))==-1);
if (x_num>0) && (o_num==0)
    for i=1:n
        val(i,n+1-i) = val(i,n+1-i) + pos(i,n+1-i)*(x_num^2);
    end
end
if (o_num>0) && (x_num==0)
    for i=1:n
        val(i,n+1-i) = val(i,n+1-i) + pos(i,n+1-i)*(o_num^2);
    end
end
%evaluate adverse diag

end