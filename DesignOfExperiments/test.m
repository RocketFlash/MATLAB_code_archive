x = 1:10;
y = sin(x);
z = cos(x);
for i = 1:2
    figure;
    plot(x,y)
    title(num2str(i))
    figure;
    plot(x,z)
    title(num2str(i))
end