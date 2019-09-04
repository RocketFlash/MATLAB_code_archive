clear;

load('pc_colored_zaits.mat')

cloud = pc.Location;
color = pc.Color;

n = pc.Count;

% cloud2 = cloud;
% color2 = color;

points_count = 1;
for i=1:n
    if (cloud(i,1)>-0.1) && (cloud(i,1)<0.2) && (cloud(i,2)>-0.16) && (cloud(i,3)<0.7) && (cloud(i,3)>0.58)
        cloud2(points_count,:) = cloud(i,:);
        color2(points_count,:) = color(i,:);
        points_count = points_count+1;
    end
end

pc2 = pointCloud(cloud2,'Color',color2);
pcshow(pc2);

