function [J,t,S,F] = generatePoints(V,T,desc)
%S start indexes of trapezas
%F end indexes of trapezas
m = size(V,1);
k = size(V,2);
last = T(4,k);
step = 1/desc;
t = T(1,1):step:last;
J = zeros(m,fix(last*desc));
p = 1;
S = zeros(k);
F = zeros(k);
for i = 1:k
    for j = 1:m
        J(j,p:fix(T(2,i)*desc)+1) = lineVelocity(V(j,i),T(1,i),T(2,i),T(1,i):step:T(2,i));
        J(j,fix(T(2,i)*desc)+2:fix(T(3,i)*desc)) = V(j,i);
        xx = lineVelocity(V(j,i),T(4,i),T(3,i),T(3,i):step:T(4,i));
        J(j,(fix(T(3,i)*desc)+1):(fix(T(3,i)*desc)+1)+size(xx,2)-1) = xx;
    end
    S(i) = p;
    F(i) = fix(T(4,i)*desc)+1;
    p = F(i);
end
figure;
hold on
plot(t,J(1,:),'--r',t,J(2,:),'--g',t,J(3,:),'--b','LineWidth',1);
grid on
legend('joint1','joint2','joint3')
xlabel('time','FontSize',14);
ylabel('Velocity','FontSize',14);
end

