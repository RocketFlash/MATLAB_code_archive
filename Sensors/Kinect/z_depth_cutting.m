cloud = pc.Location;
color = pc.Color;

n = pc.Count;

% cloud2 = cloud;
% color2 = color;

points_count = 1;
for i=1:n
    if cloud(i,3)<0.7
        cloud2(points_count,:) = cloud(i,:);
        color2(points_count,:) = color(i,:);
        points_count = points_count+1;
    end
end
   
   