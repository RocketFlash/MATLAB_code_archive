function Qmin = gridSearch(lowerBound,upperBound,steps,numberOfConfigurations)
Qmin = zeros(16,7);
% Q = zeros(16,7);
lowerBound = repmat(lowerBound,[1,numberOfConfigurations]);
upperBound = repmat(upperBound,[1,numberOfConfigurations]);
steps = repmat(steps,[1,numberOfConfigurations]);
for i1 = lowerBound(1):steps(1):upperBound(1)
    for i2 = lowerBound(2):steps(2):upperBound(2)
        for i3 = lowerBound(3):steps(3):upperBound(3)
            for i4 = lowerBound(4):steps(4):upperBound(4)
                for i5 = lowerBound(5):steps(5):upperBound(5)
                    for i6 = lowerBound(6):steps(6):upperBound(6)
                        for i7 = lowerBound(7):steps(7):upperBound(7)
                            Q = 1;
                        end
                    end
                end
            end
        end
    end
end
Qmin=Q;
end

