%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%     Design a controller    %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = tf('s');
sys = (s+3)/(2*s^3+4*s^2+7*s+13);
controller = pidtune(sys,'pd');

SP =1 ;

sys1 = minreal(sys/(1+sys));
sys2 = minreal(controller * sys/(1+controller * sys));

figure
step(sys1)
figure
step(sys2)

S1 = stepinfo(sys1);
sserror1=abs(SP-dcgain(sys1));
overshoot1 = S1.Overshoot;
riseTime1 = S1.RiseTime;

S2 = stepinfo(sys2);
sserror2=abs(SP-dcgain(sys2));
overshoot2 = S2.Overshoot;
riseTime2 = S2.RiseTime;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%     Design a compensator    %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Firstly I use: 
% controlSystemDesigner(sys1);
% to find optimal lead compensator parameters
s = tf('s');
sys = (s+3)/(2*s^3+4*s^2+7*s+13);
compensator = 4.0914*tf([0.81 1],[0.11 1]); 
total = compensator*sys;
ttt = total/(1+total);
step(ttt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%  State Space Model in Controllable Canonical Form   %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num = [1,3];
den = [2 4 7 13];
ssq = tf(num,den);
[A,B,C,D] = tf2ss(num,den);
A = rot90(A,2);
B = rot90(B,2);
C = rot90(C,2);
D = rot90(D,2);

