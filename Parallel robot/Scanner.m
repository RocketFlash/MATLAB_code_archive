function ColorMatrix = Scanner(x,y)
     
ColorMatrix = zeros(x,y);
syms noColor black blue green yellow red white brown
b=Brick('ioType','usb');
toKill = 1;
for i = 1:x
    for j = 1:y
        
        delx = 34/(x-1);
        dely = 23.5/(y-1);
        coorx =  1.5 + (i-1)*delx;
        coory = 3+(j-1)*dely;
        whereIsMyMatches(coorx,coory,b);
        whereIsMyMatches(coorx,coory,b);
        whereIsMyMatches(coorx,coory,b); 
        whereIsMyMatches(coorx,coory,b);
        whereIsMyMatches(coorx,coory,b);
        whereIsMyMatches(coorx,coory,b);
        ColorMatrix(i,j) = whereIsMyMatches(coorx,coory,b)
        
        if ColorMatrix(i,j) == 7
            ColorMatrix(i,j) = 4;
        end
        
        if toKill == 7
            toKill = 4;
        end
        
        if toKill > x
            toKill = rem(toKill,x);
        end
        
        if j == toKill
            Kill(coorx,coory,b);
            toKill = ColorMatrix(i,j);
            break;
        end
%         
%         b.outputStepSpeed(0,Device.MotorC,motorSpeed,0,200,0,Device.Coast);
%         while(b.outputTest(0,Device.MotorC))
%                 pause(0.1)
%         end

%         switch col
%             case  0
%                 ColorMatrix(i,j)= noColor;
%             case  1
%                 ColorMatrix(i,j)= black;
%             case  2
%                 ColorMatrix(i,j)= blue;
%             case  3
%                 ColorMatrix(i,j)= green;
%             case  4
%                 ColorMatrix(i,j)= yellow;
%             case  5
%                 ColorMatrix(i,j)= red;
%             case  6
%                 ColorMatrix(i,j)= white;
%             case  7
%                 ColorMatrix(i,j)= brown;
%         end
        
    end
end

        delx = 35/(x-1);
        dely = 23.5/(y-1);
        coorx =  1.5 + (1-1)*delx;
        coory = 3+(1-1)*dely;
        whereIsMyMatches(coorx,coory,b);
        b.beep();
R=zeros(x+1,y+1);
R(1:x,1:y)=ColorMatrix;
pcolor(R);
end

