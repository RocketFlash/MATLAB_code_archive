function Y = getXY(f,n,X)
switch n
    case 1
        Y = f.a1*sin(f.b1*X+f.c1);
    case 2
        Y = f.a1.*sin(f.b1.*X+f.c1)+f.a2.*sin(f.b2.*X+f.c2);
    case 3
        Y = f.a1*sin(f.b1*X+f.c1)+f.a2*sin(f.b2*X+f.c2)+f.a3*sin(f.b3*X+f.c3);
end
end

