% Rauf Yagfarov
% Timur Mamakov
% Viktor Vasilenko
function  T=TransformMatrix()
syms t1 t2 t3 d1 t5 t6
pi = sym('pi');
a=[t1 t2 t3 d1 t5 t6];
L1 = Link('d', 0, 'a', 0, 'alpha', 0,'modified');
L2 = Link('d', 0, 'a', 0, 'alpha', pi/2,'modified');
L3 = Link('d', 0, 'a', 10, 'alpha', 0, 'offset',-pi/2,'modified');
L4 = Prismatic('a', 0, 'alpha', pi/2,'theta',0,'modified'); 
L5 = Link('d', 0, 'a', 0, 'alpha', -pi/2,'modified');
L6 = Link('d', 0, 'a', 0, 'alpha', pi/2,'modified');
bot = SerialLink([ L1 L2 L3 L4 L5 L6],'name','my robot');
T = bot.fkine(a);
end
