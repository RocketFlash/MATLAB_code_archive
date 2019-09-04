function fractal2
clear all
global rect
rect=0;
fig=figure(1);
h1 = uicontrol('Style', 'pushbutton', ...
     'Position', [20 0 120 30],...
    'String', 'generate',...
    'Callback', @BtnCall);
h2 = uicontrol('Style', 'pushbutton', ...
     'Position', [150 0 120 30],...
    'String', 'zoom',...
    'Callback', @BtnCall2);
tic
colormap(jet(3))
ezcontourf(@fractal,-2:0.00001:0.5,-1.25:0.00001:1.25,200)
toc
% axis( [-2 0.5 1.25 1.25 ] )
n=800;

function BtnCall(src,evt)
ezcontourf(@fractal,rect(1):rect(3)/4000:rect(1)+rect(3),rect(2):rect(4)/4000:rect(2)+rect(4),n)
axis( [ rect(1),rect(1)+rect(3), rect(2), rect(2)+rect(4) ] )
end

function BtnCall2(src,evt)
rect=getrect;
axis( [ rect(1),rect(1)+rect(3), rect(2), rect(2)+rect(4) ] ) 
end
end