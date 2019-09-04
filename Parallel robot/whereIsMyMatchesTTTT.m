function whereIsMyMatchesTTTT()

disp('Connecting...')
b=Brick('ioType','usb');
delete(b);
b=Brick('ioType','usb');
disp('Connection complete');
b.beep(); 
% b.outputClrCount(0,1);
% b.outputClrCount(0,2);
motorSpeed = 15; 

    alpha = 30;
    beta = 30;
    
    differA = alpha - b.outputGetCount(0,Device.MotorA)
    differB = beta - b.outputGetCount(0,Device.MotorA)
    
    b.outputStart(0,Device.MotorA);
    b.outputStart(0,Device.MotorB);
    b.outputPower(0,Device.MotorA,0);
    b.outputPower(0,Device.MotorB,0);
    
    b.outputStop(0,Device.MotorB,Device.Coast)   
    c=0;
    while c<200
        differA = alpha - b.outputGetCount(0,Device.MotorA);
        newPower = (differA/10);
        if newPower>0
            newPower = newPower+5;
        else
            newPower = newPower-5;
        end
        if newPower>50
            newPower = 50
        end
        if newPower<-50
            newPower = -50
        end
        b.outputPower(0,1,newPower);
        pause(0.05);
        c=c+1;
    end
    b.outputPower(0,1,0);
        
    b.outputStop(0,1);
    
disp('Thank you!');

delete(b);
clear;
end