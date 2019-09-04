function [X,Y]=Lorentz(s,w,a) %shift,width,amplitude
num=50;%number of points
b=1.5;%scale 
X=zeros(b*num);
Y=zeros(b*num);

X=[-b*num:0.1:b*num];
Y=a./(1+((X-s).^2)/(w)^2);
%  plot(X,Y);
end

