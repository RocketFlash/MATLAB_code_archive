function Q = generateConfig(lng,tet)
n = length(lng);
m = length(tet);
Q = zeros(n^3*m^2,5);
j = 1;
for i1 = 1:n
    for i2 = 1:n
        for i3 = 1:n
            for i4 = 1:m
                for i5 = 1:m
                    Q(j,:) = [lng(i1),lng(i2),lng(i3),tet(i4),tet(i5)];
                    j=j+1;
                end
            end
        end
    end
end
                    

end

