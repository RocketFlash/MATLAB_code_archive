% Making Surface Plots From Scatter Data

%% Load the data

M = csvread('coordinates.csv',0,0);
x = [M(:,1)', M(:,4)',M(:,7)',M(:,10)',M(:,13)'];
y = [M(:,2)', M(:,5)',M(:,8)',M(:,11)',M(:,14)'];
z = [M(:,3)', M(:,6)',M(:,9)',M(:,12)',M(:,15)'];


%%
% The problem is that the data is made up of individual (x,y,z)
% measurements. It isn't laid out on a rectilinear grid, which is what the
% SURF command expects. A simple plot command isn't very useful.

plot3(x,y,z,'.-')

%% Little triangles
% The solution is to use Delaunay triangulation. Let's look at some
% info about the "tri" variable.

tri = delaunay(x,y);
plot(x,y,'.')

%%
% How many triangles are there?

[r,c] = size(tri);
disp(r)

%% Plot it with TRISURF

figure
h = trimesh(tri, x, y, z);
axis equal

figure
h = trisurf(tri, x, y, z);
axis equal

%% Clean it up

l = light('Position',[-50 -15 29])
set(gca,'CameraPosition',[208 -50 7687])
lighting phong
shading interp
colorbar EastOutside
