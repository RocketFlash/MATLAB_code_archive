%author Yagfarov Rauf
%Assignment 3

function stopper()

disp('Connecting...')
b=Brick('ioType','usb');
disp('Connection complete');
b.beep(); 
b.outputClrCount(0,1);
b.outputClrCount(0,2);
motorSpeed = 5; 
%reading = b.inputReadSI(0,Device.Port1,Device.ColColor);

    a = invers(0,0).*180/pi;
    alpha = 0;
    beta = 0;
    b.outputStepSpeed(0,Device.MotorA,motorSpeed,0,alpha,0,Device.Coast);
    b.outputStepSpeed(0,Device.MotorB,motorSpeed,0,beta,0,Device.Coast);
    b.outputStepSpeed(0,Device.MotorC,-15,0,50,0,Device.Coast);
    while(b.outputTest(0,Device.MotorA))
        pause(0.1)
    end
    
    while(b.outputTest(0,Device.MotorB))
        pause(0.1)
    end
    
%     [alpha , beta] = invers(0,26);
%
%     [alpha , beta] = invers(38,26);
%     
%     [alpha , beta] = invers(38,0);
%        
    %Setting motors before turning
   
   

disp('Thank you!');

delete(b);
clear;
end



