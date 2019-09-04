function Q = generateRandomConfig(num)
Q = zeros(num,5);
for i = 1:num
    Q(i,:) = [rand(),rand(),rand(),(randn()-0.5)*4*pi/3,(randn()-0.5)*4*pi/3];             
end
end

