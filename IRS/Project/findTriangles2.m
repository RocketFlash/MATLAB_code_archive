% I = fliplr(videodata1(:,:,:,20));
I = imread('q1.png');
I = rgb2gray(I);
I = imcomplement(I);
I = medfilt2(I,[3,3]);
I = adapthisteq(I,'Range','original');
I = imadjust(I);
threshold = graythresh(I);

% marker = imerode(I, strel('line',10,0));
% Iclean = imreconstruct(marker, I);
BW2 =~im2bw(I,0.5);
% 
% figure;
% imshowpair(I, BW2, 'montage');
% results = ocr(BW2, 'TextLayout', 'Block');


     ocrResults   = ocr(BW2);
     Iocr         = insertObjectAnnotation(I, 'rectangle', ...
                           ocrResults.WordBoundingBoxes, ...
                           ocrResults.WordConfidences);
     figure; imshow(Iocr);

ocrResults.Text

