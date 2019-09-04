% A=load('data.dat');
% plot(A(:,1),A(:,2));

A = magic(9)
B = sin(A)

plot(A(4,3:8),B(4,3:8));