% Rauf Yagfarov
% Timur Mamakov
% Viktor Vasilenko
function qVelocities = from3D2J(EE)
L1 = Link('d', 0, 'a', 0, 'alpha', 0,'modified');
L2 = Link('d', 0, 'a', 0, 'alpha', pi/2,'modified');
L3 = Link('d', 0, 'a', 10, 'alpha', 0, 'offset',-pi/2,'modified');
L4 = Prismatic('a', 0, 'alpha', pi/2,'theta',0,'modified'); 
L5 = Link('d', 0, 'a', 0, 'alpha', -pi/2,'modified');
L6 = Link('d', 0, 'a', 0, 'alpha', pi/2,'modified');
bot = SerialLink([ L1 L2 L3 L4 L5 L6],'name','my robot');
%plotting the robot
bot.plotopt={'workspace',[-20,20,-20,20,-20,20]};

q0=[0 0 0 10 0 0]; 
t = 5; 

x =tr2delta(bot.fkine(q0));
y=EE;
T=delta2tr(y + x);
q1= HOWTO(T(1,4),T(2,4),T(3,4));

%calculation of Jacobian
J=jacob0(bot,q1);
qVelocities=inv(J)*EE; 
%plotting the robot
time=0:0.2:t; 
traj=jtraj(q0,q1,time); 
bot.plot(traj); 

end

