
q1 = rgb2gray(imread('q1.png'));
q2 = rgb2gray(imread('q2.png'));
q3 = rgb2gray(imread('q3.png'));

outfile = 'out.gif';
set(gca,'nextplot','replacechildren')

samples = {q1,q2,q3};
numSam = length(samples);
b = cell(1,numSam);
params = cell(1,numSam+1);
sizes = [size(samples{1}, 1), size(samples{1}, 2)];
params{1} = sizes;
for k = 1:numSam
    b{k} = detectSURFFeatures(samples{k});
    [bf, bp] = extractFeatures(samples{k},b{k});
    params{k+1} = {bf,bp};
end

colors = {[1,0,0],[0,1,0],[0,0,1]};
rooms = {'No sign','Room 474','Room 473','Room 471'};
qq = SI(:,:,:,1:50);



pred = zeros(1,5);
ff=1;
for i = 1:size(SI,4)
    sceneImage = SI(:,:,i);
    [matchedBoxPoints, matchedScenePoints, inda] = doorNumberDetector(sceneImage,params);
    pred(ff) = inda;
    colorClass = mode(pred);
    if colorClass == 0
        color = [];
    else
        color = colors{colorClass};
    end
    plotImage(sceneImage,matchedBoxPoints, matchedScenePoints, color,params{1});
    text(50,50,strcat('\fontsize{20}\color{red}',rooms{colorClass+1}));
    pause(0.001);
    if ff==5
        ff=1;
    else
        ff = ff + 1;
    end
    
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 1
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'LoopCount',inf);
    else
        imwrite(imind,cm,outfile,'gif','DelayTime',0,'WriteMode','append');
    end
end



