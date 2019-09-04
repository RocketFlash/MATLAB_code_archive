% cloud2 = pc.Location;
% color2 = pc.Color;

n = points_count-1;

% cloud2 = cloud;
% color2 = color;

points_count = 1;
for i=1:n
    if cloud2(i,2)>-0.17
        cloud3(points_count,:) = cloud2(i,:);
        color3(points_count,:) = color2(i,:);
        points_count = points_count+1;
    end
end
hold on;
plot3 (cloud2(:,1),cloud2(:,2),cloud2(:,3),'.')
plot3 (cloud3(:,1),cloud3(:,2),cloud3(:,3),'.')
