%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%     Design a controller    %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = tf('s');
sys = (s+3)/(2*s^2 + 4);
controller = pidtune(sys,'pid');

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
sys = (s+3)/(2*s^2 + 4);
compensator = 165.65*tf([0.066 1],[0.25 1]); 
total = compensator*sys;
ttt = total/(1+total);
figure
step(ttt)
S3 = stepinfo(ttt);

figure
nyquist(sys1)
figure
nyquist(ttt)
sserror3=abs(SP-dcgain(ttt));
