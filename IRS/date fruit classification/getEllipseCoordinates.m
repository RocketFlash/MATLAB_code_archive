% Yagfarov Rauf
% Mamakov Timur
% Innopolis University


function [x,y] = getEllipseCoordinates(s)
phi = linspace(0,2*pi,50);
cosphi = cos(phi);
sinphi = sin(phi);

    xbar = s(1).Centroid(1);
    ybar = s(1).Centroid(2);

    a = s(1).MajorAxisLength/2;
    b = s(1).MinorAxisLength/2;

    theta = pi*s(1).Orientation/180;
    R = [ cos(theta)   sin(theta)
         -sin(theta)   cos(theta)];

    xy = [a*cosphi; b*sinphi];
    xy = R*xy;

    x = xy(1,:) + xbar;
    y = xy(2,:) + ybar;
end

