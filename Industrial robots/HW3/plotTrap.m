%graphic representation of velocities trapeza
function plotTrap(V,T)

clr = [1,0,0;0,1,0;0,0,1];
hold on
for i = 1:size(V,2)
    for j = 1:size(V,1)
        plot([T(1,i),T(2,i)],[0,V(j,i)],'Color',clr(j,:),'LineWidth',1);
        plot([T(2,i),T(3,i)],[V(j,i),V(j,i)],'Color',clr(j,:),'LineWidth',1);
        plot([T(3,i),T(4,i)],[V(j,i),0],'Color',clr(j,:),'LineWidth',1);
    end
end
hold off
grid on
end

