function  Cube(T)
sidelength = 5;
verts = ([0 0 0;0 1 0;1 1 0;1 0 0;0 0 1;0 1 1;1 1 1;1 0 1]-0.5).*sidelength; 
newverts = verts;
for i = 1:size(verts,1)
    new = T * [verts(i,:) 1]';
    newverts(i,:) = new(1:3)';
end
face = [1 2 3 4;5 6 7 8;3 4 8 7;1 2 6 5;2 3 7 6;1 4 8 5];
cdata = [
    0 0 0; % black
    1 0 0; % red
    1 0 1; % magenta
    0 0 1; % blue
    0 1 0; % green
    1 1 0; % yellow
    1 1 1; % white
    0 1 1; % cyan
    ];
hold on
axis('equal');
h = patch('Faces',face,'Vertices',verts,'FaceVertexCData',cdata,'FaceColor','interp','EdgeColor','black');
tranimate(T,'axis',[-25, 25, -25, 25, -25, 25]);
h = patch('Faces',face,'Vertices',newverts,'FaceVertexCData',cdata,'FaceColor','interp','EdgeColor','black');
%axis([-2*sidelength 2*sidelength -2*sidelength 2*sidelength])
axis equal;
view(3);
grid on
end

