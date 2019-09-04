% load topo;
% n=128;
% [x,y,z]=sphere(n);
% sh=surface(x,y,z,...
%            'facecolor','texturemap',...
%            'cdata',topo);

axis equal;
grid on
view(3);

n = 30;
step = (2*pi)/n;
xyz = [3;0;0];

for i=1:n
    hold on
     xyz = Rz(step)*xyz;
     plot3(xyz(1),xyz(2),xyz(3),'*');
     xlim([-5,5])
ylim([-5,5])
zlim([-5,5])
     pause(0.5);
end
xlim([-5,5])
ylim([-5,5])
zlim([-5,5])