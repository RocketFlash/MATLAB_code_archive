
intrinsic = [815.9258654933619, 0, 500;
 0, 804.1900671430133, 375;
 0, 0, 1];

world = [0, 0, 0;
 297, 0, 0;
 297, 210, 0;
 0, 210, 0];

translationT = [-195,135,-845;
                425,215,-845;
                215,225,-885;];
            
translation = [-128.236464, 141.118934, -963.950772;
460.883139, 315.137900, -888.334803;
323.573469, 352.675724, -865.045807
];rotation = [0.105477, 0.416759, -0.028450;
0.278488, -0.174722, 0.043320;
0.324851, -0.034083, 0.004391
];

translationBig = [-254.045044, 71.931037, -851.149294;
495.510137, 283.796372, -856.231872;
346.366054, 256.015438, -884.712871
];rotationBig = [0.039254, 0.575628, -0.016321;
0.252824, -0.220220, 0.042153;
0.218361, -0.059185, 0.002627
];
% cameraParams = cameraParameters('IntrinsicMatrix',intrinsic,'RotationVectors', rotation,'TranslationVectors', translation, 'WorldPoints' , world );
% showExtrinsics(cameraParams,'patternCentric');

r = 5;

hold on
fill3( [0 297 297 0 0], [0 0 210 210 0], [0 0 0 0 0], [0,0,0,0,0])
% plot3([0, 500,  0, 0, 0, 0],...
%        [0, 0,  0, 500, 0, 0],...
%        [0, 0,  0, 0, 0, 500] )
% 
% text([0+500, 0, 0], [0, 0+500, 0], [0, 0, 0+500], ['+X';'+Y';'+Z']);
plot3(translation(1,1), translation(1,2),  translation(1,3),'r*')
plot3(translation(2,1), translation(2,2), translation(2,3),'r*')
plot3(translation(3,1), translation(3,2), translation(3,3),'r*')
plot3(translationBig(1,1), translationBig(1,2), translationBig(1,3),'g*')
plot3(translationBig(2,1), translationBig(2,2), translationBig(2,3),'g*')
plot3(translationBig(3,1), translationBig(3,2), translationBig(3,3),'g*')
plot3(translationT(1,1), translationT(1,2),  translationT(1,3),'b*')
plot3(translationT(2,1), translationT(2,2), translationT(2,3),'b*')
plot3(translationT(3,1), translationT(3,2), translationT(3,3),'b*')
% quiver3(translation(:,1),translation(:,2),translation(:,3),rotationVectors(:,1),rotationVectors(:,2),rotationVectors(:,3));
grid on
axis equal
% legend('true position','original image', 'resized image');
% axis([-1000 1000 -1000 1000 -1000 100]) 