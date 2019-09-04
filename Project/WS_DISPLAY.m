% Rauf Yagfarov
% Timur Mamakov
% Viktor Vasilenko
function   WS_DISPLAY()

L1 = Link('d', 0, 'a', 0, 'alpha', 0,'modified');
L2 = Link('d', 0, 'a', 0, 'alpha', pi/2, 'offset',pi/2,'modified');
L3 = Link('d', 0, 'a', 0, 'alpha', -pi/2,'modified');
L4 = Link('d', 0, 'a', 10, 'alpha', 0, 'offset',pi,'modified');
L5 = Prismatic('a', 0, 'alpha', -pi/2,'theta',pi,'modified');

bot = SerialLink([ L1 L2 L3 L4 L5],'name','my robot');
bot.plotopt={'workspace',[-20,20,-20,20,-20,20]};
bot.base(1);
X = ones(1,20000);
Y = ones(1,20000);
Z = ones(1,20000);
i=1;
for t1 = -pi/2:0.4:2*pi/2
    for t2 = -pi/2:0.4:pi/2
        for t3 = -pi/2:0.4:pi/2
            for t4 = -pi:0.4:pi
                for d1 = 0:2:10
                     ee = bot.fkine([t1 t2 t3 t4 d1]);
                     X(i) = ee(1,4);
                     Y(i) = ee(2,4);
                     Z(i) = ee(3,4);
                     i=i+1;
                end
            end
        end
    end
end

plot3(X,Y,Z,'.b')

end

