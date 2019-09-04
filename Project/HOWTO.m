% Rauf Yagfarov
% Timur Mamakov
% Viktor Vasilenko
function answer = HOWTO(x,y,z)
d= sqrt(x^2+y^2+z^2);
r = 10;
t1 = atan2(y,x);
t3 = 0;
t2 = asin(z/d) - asin((r*sin(t3))/d);
d4 = r-d;
t5 = atan2(z,sqrt(x^2+y^2)) - t2 - t3;
t6 = atan2(y,x) - t1;
answer = [t1 t2 t3 d4 t5 t6];
end

