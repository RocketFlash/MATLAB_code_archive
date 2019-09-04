% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

function res = posOptimizer(position)

res = position;
e = energy(res);

%flip up to down
flip = flipud(position);
if energy(flip) < e
    e = energy(flip);
    res = flip;
end

%main diagonal flip 
flip = rot90(flip);
if energy(flip) < e
    res = flip;
end

%flip left to right
flip = fliplr(position);
if energy(flip) < e
   e = energy(flip);
   res = flip;
end

%second diagonal flip
flip = rot90(flip);
if energy(flip) < e
    res = flip;
end

%rotate clockwise
for i = 1:3
    flip = rot90(position,i);
    if energy(flip)<e
        res = flip;
    end
end


end

% "Energy" of position
function res = energy(pos)
    res = 0;
    for i=1:(size(pos(:)))
        res = res + ((pos(i)+0.01)^2)*i;
    end
end