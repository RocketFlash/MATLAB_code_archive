function myplot(p)
hold on
plot(p(:,1),p(:,2))
%plotting coords

for i=1:size(p,1)
    line([p(i,1);p(i,1)+0.2*cos(p(i,3))],[p(i,2);p(i,2)+0.2*sin(p(i,3))],'color','r');
end
%plotting 

hold off;

end