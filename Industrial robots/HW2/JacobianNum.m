function Jnum = JacobianNum(J,PI,PI0,Q,L)
m = size(L,1);
Jnum = zeros(3*m,length(PI));
for i=1:m
Jnum((3*i-2):(3*i),:) = double(vpa(subs(J,[PI,Q],[PI0,L(i,:)])));
end

end

