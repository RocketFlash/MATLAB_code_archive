function color = whereIsMyMatches(x,y,b)

disp('Connecting...')
disp('Connection complete');
b.beep(); 
motorSpeed = 2; 



    a = invers(x,y);
    tachoA =b.outputGetCount(0,Device.MotorA); 
    tachoB = b.outputGetCount(0,Device.MotorB); 
    alpha = a(1) - tachoA;
    beta = a(2) - tachoB;
    
    if alpha>=0
        t1=1;
    else
        t1=-1;
    end
    
    if beta>=0
        t2=1;
    else
        t2=-1;
    end
    
%     alpha=abs(alpha);
%     beta=abs(beta);
    b.outputStepSpeed(0,Device.MotorA,motorSpeed*t1,0,alpha,0,Device.Coast);
    b.outputStepSpeed(0,Device.MotorB,motorSpeed*t2,0,beta,0,Device.Coast);
%     
%  
    while(b.outputTest(0,Device.MotorA))
        pause(0.05)
    end
    
    while(b.outputTest(0,Device.MotorB))
        pause(0.05)
    end
%     pause(0.5);
   color = b.inputReadSI(0,Device.Port1,Device.ColColor);
end



