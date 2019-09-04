%function returns graphs with goint angles distribution
%input:
%angles - vector of angles of joints
%       angles = [q11,q12,q13,...q1k,...qm1,...qmk]
%jointNumbers - number of joints
function plotAnglesCircle(angles,jointNumber)

lw = 1.5;      % LineWidth
msz = 8;       % MarkerSize

phi = linspace(0,2*pi,1000);
xd = cos(phi);
yd = sin(phi);

w = floor(sqrt(jointNumber));
h = ceil(jointNumber/w);

for i = 1:jointNumber
angl = angles(i:jointNumber:end);
xp = cos(angl);
yp = sin(angl);
subplot(w,h,i)
plot(xd,yd,xp,yp,'or','LineWidth',lw,'MarkerSize',msz)
xlim([-1.2,1.2])
ylim([-1.2,1.2])
xlabel(strcat('cos(q',num2str(i),')'))
ylabel(strcat('sin(q',num2str(i),')'))
title(strcat('Q',num2str(i)))
axis square 
grid on
end

end

