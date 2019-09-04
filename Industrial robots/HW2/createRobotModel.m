%Robot model in Robotics toolbox
L1 = Link('prismatic', 'a',0,'alpha',0, 'theta', pi/2,'modified');
L2 = Link('prismatic', 'a',0,'alpha',pi/2, 'theta', pi/2,'modified');
L3 = Link('prismatic', 'a',0,'alpha',pi/2, 'theta', 0,'modified');
L4 = Link('revolute', 'a',0,'alpha',0, 'd',0,'modified');
L5 = Link('revolute', 'a',0,'alpha',-pi/2, 'd', 0,'modified');
L6 = Link('prismatic', 'a',0,'alpha',pi/2, 'theta', 0,'modified');

bot = SerialLink([L1 L2 L3 L4 L5 L6], 'name', 'Cartesian 5D robot');

bot.plotopt={'workspace',[-1,1,-1,1,-1,1]};
bot.plot([0.500,0.500,0.500,-pi,pi/2,0.2])
 