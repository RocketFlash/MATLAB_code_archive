function res = ARCPLOT(from,to,n,r,C,color)


steps = from:(to-from)/n:to;
pointsX = r * cos(steps) + C(1);
pointsY = r * sin(steps) + C(2);
res = plot(pointsX,pointsY,color);
end