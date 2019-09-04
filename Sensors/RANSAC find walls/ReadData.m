function [X,Y] = ReadData(src)
A=load(src);
D=A.unnamed;
T=(0:681)*(240/682);
X=D.*cos(pi/180*T');
Y=D.*sin(pi/180*T');
end

