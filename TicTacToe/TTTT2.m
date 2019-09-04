% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = TTTT2 (inp_pos)
n=length(inp_pos);
pos = inp_pos==2;
pos = inp_pos - pos*3;
% casting "2" in the input position to "-1"
%it simplifies calculations

s = sum(sum(pos)); 
if s==0
    player = 1;
else if s==1
        player = -1;
    else
        fprintf('Impossible position. Number of crisses and zeros is mismatched.');
        res = [0,0];
        return;
    end
end

max_x = [-10000,0,0];
min_x = [10000,0,0];
for i=1:n
    for j=1:n
        if pos(i,j)==0
            branch = pos;
            branch(i,j) = player;
            x = sum(sum(EVALUATE(branch)));
            if x>max_x(1)
                max_x = [x,i,j];
            end
            if x<min_x(1)
                min_x = [x,i,j];
            end
        end
    end
end

if player==1
    res = max_x(2:3);
else
    res = min_x(2:3);
end
end