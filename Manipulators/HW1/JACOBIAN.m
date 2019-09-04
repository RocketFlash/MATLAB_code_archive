function J = JACOBIAN(teta1,teta2)
coef = pi/180;
teta1 = coef*teta1;
teta2 = coef*teta2;
L0=300;
L1=300;
L2=100;

A1x = 0;
A1y = 0;
A2x = L0;
A2y = 0;

B1x = A1x + L1*cos(teta1);
B1y = A1y + L1*sin(teta1);
B2x = A2x + L1*cos(teta2);
B2y = A2y + L1*sin(teta2);

d = sqrt((B2x-B1x)^2 + (B2y-B1y)^2);
phi = atan2(sqrt(L2^2-(d/2)^2),d/2);
alpha = atan2(B2y-B1y,B2x-B1x);

B1xt1 = -L1*sin(teta1);
B1xt2 = 0;
B1yt1 = L1*cos(teta1);
B1yt2 = 0;
B2xt1 = 0;
B2xt2 = -L1*sin(teta2);
B2yt1 = 0;
B2yt2 = L1*cos(teta2);

dt1 = (2*B2x*B2xt1 - (2*B2x*B1xt1+2*B2xt1*B1x)+2*B1x*B1xt1+2*B2y*B2yt1-(2*B2y*B1yt1+2*B2yt1*B1y)+2*B1y*B1yt1)/(2*d);
dt2 = (2*B2x*B2xt2 - (2*B2x*B1xt2+2*B2xt2*B1x)+2*B1x*B1xt2+2*B2y*B2yt2-(2*B2y*B1yt2+2*B2yt2*B1y)+2*B1y*B1yt2)/(2*d);
phit1 = (1/(1+phi^2))*((d/2)*(1/(2*sqrt(L2^2-(d/2)^2)))*(-d*dt1)-(1/2)*dt1*((1/(2*sqrt(L2^2-(d/2)^2)))))/((d/2)^2);
phit2 = (1/(1+phi^2))*((d/2)*(1/(2*sqrt(L2^2-(d/2)^2)))*(-d*dt2)-(1/2)*dt2*((1/(2*sqrt(L2^2-(d/2)^2)))))/((d/2)^2);
alphat1 = (1/(1+alpha^2))*((B2yt1-B1yt1)*(B2x-B1x)-(B2xt1-B1xt1)*(B2y-B1y))/((B2x-B1x)^2);
alphat2 = (1/(1+alpha^2))*((B2yt2-B1yt2)*(B2x-B1x)-(B2xt2-B1xt2)*(B2y-B1y))/((B2x-B1x)^2);

beta1 = alpha + teta1;
beta2 = -teta1- teta2-beta1+2*phi-4*pi;

beta1t1 = alphat1+phit1 + 1;
beta1t2 = alphat2+phit2;
beta2t1 = -1 - beta1t1 + 2* phit1;
beta2t2 = -1 - beta1t2 + 2* phit2;

J = [(B1xt1 - L2*sin(alpha+phi)*(alphat1+phit1)),(B1xt2 - L2*sin(alpha+phi)*(alphat2+phit2)); B1yt1 + L2*cos(alpha+phi)*(alphat1+phit1),B1yt2 + L2*cos(alpha+phi)*(alphat2+phit2);beta1t1,beta1t2;beta2t1,beta2t2;alphat1+phit1,alphat2+phit2];

end

