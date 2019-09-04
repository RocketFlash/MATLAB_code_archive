Z = imread ('image1.jpg');
R = Z(:,:,1);
G = Z(:,:,2);
B = Z(:,:,3);

Timage  = Z(Z > 3);