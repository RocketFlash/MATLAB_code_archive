%parameters of transfer function from HW2-1
T1 = 3.75;
T2 = 1.5;
T3 = 0.15;
%delta persentage
prs = 2;
tf1 = tf(1,[T1,1]);
tf2 = tf([19*T2,19],[T3,1]);
tf3 = tf(1,[T1 0]);
%plot graphics or not
%1 - plot
%0 - don't plot
plt = 0;

%transfer functions from HW2-1
TF1 = minreal(tf1*tf1*tf2);
TF2 = minreal(tf3*tf1*tf2);
TF3 = minreal(tf3*tf3*tf2);
TF1 = minreal(TF1/(1+TF1));
TF2 = minreal(TF2/(1+TF2));
TF3 = minreal(TF3/(1+TF3));

%transfer functions from HW1-3
tf1 = tf(2,[1,5]);
tf2 = tf([1,1],[1,0.5]);
tf3 = tf(1,[1,0.25]);
tf4 = tf(1,[2,3]);
tff = tf2/(1+tf2*tf4);
TF4 = minreal(tf1*tff*tf3); 

%transfer function from HW3
TF5 = tf(3,[0.3,0.1,1]);

%step function amplitude
SP=1; 

%%%%%%%%%%%%%%%%%%%%%Transient process%%%%%%%%%%%%%%%%%%%
[y,t]=step(SP*TF1,10*T1);
%get the steady state error
sserror1=abs(SP-dcgain(TF1));
if plt
    figure(1);
    plot(t,y)
    grid on
    title('TF1')
    saveas(1, 'StepTF1', 'png')
end
%calculate sigma
sigma1 = ((max(y)- dcgain(TF1))/max(y))*100;
qq = dcgain(TF1)*0.01*prs;
tm1 = 0;
%calculate transient process time
for i=length(y):-1:1
    if abs(y(i)-dcgain(TF1))>=qq
        tm1 = t(i);
        break;
    end
end


[y,t]=step(SP*TF2,10*T1);
%get the steady state error
sserror2=abs(SP-dcgain(TF2));
if plt
    figure(2);
    plot(t,y)
    grid on
    title('TF2')
    saveas(2, 'StepTF2', 'png')
end
sigma2 = ((max(y)- dcgain(TF2))/max(y))*100;
qq = dcgain(TF2)*0.01*prs;
tm2 = 0;
for i=length(y):-1:1
    if abs(y(i)-dcgain(TF2))>=qq
        tm2 = t(i);
        break;
    end
end

[y,t]=step(SP*TF3,10*T1);
%get the steady state error
sserror3=abs(SP-dcgain(TF3)); 
if plt
    figure(3);
    plot(t,y)
    grid on
    title('TF3')
    saveas(3, 'StepTF3', 'png')
end
sigma3 = ((max(y)- dcgain(TF3))/max(y))*100;
qq = dcgain(TF3)*0.01*prs;
tm3 = 0;
for i=length(y):-1:1
    if abs(y(i)-dcgain(TF3))>=qq
        tm3 = t(i);
        break;
    end
end


[y,t]=step(SP*TF4,10*T1);
%get the steady state error
sserror4=abs(SP-dcgain(TF4)); 
if plt
    figure(4);
    plot(t,y)
    grid on
    title('TF4')
    saveas(4, 'StepTF4', 'png')
end
sigma4 = ((max(y)- dcgain(TF4))/max(y))*100;
qq = dcgain(TF4)*0.01*prs;
tm4 = 0;
for i=length(y):-1:1
    if abs(y(i)-dcgain(TF4))>=qq
        tm4 = t(i);
        break;
    end
end


[y,t]=step(SP*TF5,10*T1);
%get the steady state error
sserror5=abs(SP-dcgain(TF5)); 
if plt
    figure(5);
    plot(t,y)
    grid on
    title('TF5')
    saveas(5, 'StepTF5', 'png')
end

sigma5 = ((max(y)- dcgain(TF5))/max(y))*100;
qq = dcgain(TF5)*0.01*prs;
tm5 = 0;
for i=length(y):1
    if abs(y(i)-dcgain(TF5))>=qq
        tm5 = t(i);
        break;
    end
end

%%%%%%%%%%%%%%%%%%%Root locus plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plt
    figure(6);
    rlocus(TF1)
    title('TF1')
    saveas(6, 'RootlTF1', 'png')
    figure(7);
    rlocus(TF2)
    title('TF2')
    saveas(7, 'RootlTF2', 'png')
    figure(8);
    rlocus(TF3)
    title('TF3')
    saveas(8, 'RootlTF3', 'png')
    figure(9);
    rlocus(TF4)
    title('TF4')
    saveas(9, 'RootlTF4', 'png')
    figure(10);
    rlocus(TF5)
    title('TF5')
    saveas(10, 'RootlTF5', 'png')
end

%%%%%%%%%%%%%%%%%%%%%%%Nyquist plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plt
    figure(11)
    nyquist(TF1)
    title('TF1')
    saveas(11, 'NyquistTF1', 'png')
    figure(12)
    nyquist(TF1)
    title('TF2')
    saveas(12, 'NyquistTF2', 'png')
    figure(13)
    nyquist(TF1)
    title('TF3')
    saveas(13, 'NyquistTF3', 'png')
    figure(14)
    nyquist(TF1)
    title('TF4')
    saveas(14, 'NyquistTF4', 'png')
    figure(15)
    nyquist(TF1)
    title('TF5')
    saveas(15, 'NyquistTF5', 'png')
end

%%%%%%%%%%%%%%%%%%%%Gain and phase margin calculation%%%%%%%%%%%%%%%%%
[Gm1,Pm1,Wgm1,Wpm1] = margin(TF1);
[Gm2,Pm2,Wgm2,Wpm2] = margin(TF2);
[Gm3,Pm3,Wgm3,Wpm3] = margin(TF3);
[Gm4,Pm4,Wgm4,Wpm4] = margin(TF4);
[Gm5,Pm5,Wgm5,Wpm5] = margin(TF5);

%%%%%%%%%%%Bode plot%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plt
    figure(16)
    margin(TF1);
    saveas(16, 'BodeTF1', 'png')
    figure(17)
    margin(TF2);
    saveas(17, 'BodeTF2', 'png')
    figure(18)
    margin(TF3);
    saveas(18, 'BodeTF3', 'png')
    figure(19)
    margin(TF4);
    saveas(19, 'BodeTF4', 'png')
    figure(20)
    margin(TF5);
    saveas(20, 'BodeTF5', 'png')
end

%%%%%%%%%%%%%%%%%%%%Find poles%%%%%%%%%%%%
p1 = pole(TF1);
p2 = pole(TF2);
p3 = pole(TF3);
p4 = pole(TF4);
p5 = pole(TF5);

%%%%%%%%%%%%%%%%Calculate mu%%%%%%%%%%%%%%%%
mu1 = max(abs(imag(p1)./real(p1)));
mu2 = max(abs(imag(p2)./real(p2)));
mu3 = max(abs(imag(p3)./real(p3)));
mu4 = max(abs(imag(p4)./real(p4)));
mu5 = max(abs(imag(p5)./real(p5)));

%%%%%%%%%%%%%%%Calculate ksi%%%%%%%%%%%%%%%%
dc1 = 1 - exp(-2*pi./mu1);
dc2 = 1 - exp(-2*pi./mu2);
dc3 = 1 - exp(-2*pi./mu3);
dc4 = 1 - exp(-2*pi./mu4);
dc5 = 1 - exp(-2*pi./mu5);




