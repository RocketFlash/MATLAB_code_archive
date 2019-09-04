function  plotKuka(Q)
k =2;
n = 5;
L1 = Link('revolute', 'a',0,'alpha',0,    'd', 0,'modified');
L2 = Link('revolute', 'a',0,'alpha',pi/2, 'd', 0,'modified');
L3 = Link('revolute', 'a',0,'alpha',-pi/2, 'd', 0.4,'modified');
L4 = Link('revolute', 'a',0,'alpha',-pi/2,    'd', 0,'modified');
L5 = Link('revolute', 'a',0,'alpha',pi/2,'d', 0.4,'modified');
L6 = Link('revolute', 'a',0,'alpha',pi/2, 'd', 0,'modified');
L7 = Link('revolute', 'a',0,'alpha',-pi/2, 'd', 0,'modified');

% bot = SerialLink([L1 L2 L3 L4 L5 L6 L7], 'name', 'Cartesian 5D robot');

hold on
for i = 1:size(Q,1)
subplot(k,n,i)
bot = SerialLink([L1 L2 L3 L4 L5 L6 L7], 'name', num2str(i));
bot.plotopt={'workspace',[-1,1,-1,1,-1,1]};
bot.plot(Q(i,:))
end
end

