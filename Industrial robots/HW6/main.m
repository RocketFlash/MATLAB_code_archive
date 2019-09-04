A = importdata('data.csv');
raw = A.data;
data = raw(:,2:end);
J1 = data(:,1);
J2 = data(:,2);
J3 = data(:,3);
J4 = data(:,4);
J5 = data(:,5);
J6 = data(:,6);
J7 = data(:,7);
T1 = data(:,8);
T2 = data(:,9);
T3 = data(:,10);
T4 = data(:,11);
T5 = data(:,12);
T6 = data(:,13);
T7 = data(:,14);
X = data(:,15);
Y = data(:,16);
Z = data(:,17);
A = data(:,18);
B = data(:,19);
C = data(:,20);
FX = data(:,21);
FY = data(:,22);
FZ = data(:,23);
time = 1:length(J1);
step = 0.105;
time = time.*step;
% figure;
% plot(time,J1,time,J2,time,J3,time,J4,time,J5,time,J6,time,J7,'LineWidth',1.5)
% xlabel('time (sec)','FontSize', 14);
% ylabel('Joint position (deg)','FontSize', 14);
% title('Joint positions','FontSize', 15);
% legend('J1','J2','J3','J4','J5','J6','J7')
% grid on
% 
% figure;
% plot(time,T1,time,T2,time,T3,time,T4,time,T5,time,T6,time,T7,'LineWidth',1.5)
% xlabel('time (sec)','FontSize', 14);
% ylabel('Torque (N*m)','FontSize', 14);
% title('Torques','FontSize', 15);
% legend('T1','T2','T3','T4','T5','T6','T7')
% grid on
% 
% figure;
% plot(time,FX,time,FY,time,FZ,'LineWidth',1.5)
% xlabel('time (sec)','FontSize', 14);
% ylabel('Force (N)','FontSize', 14);
% title('Forces','FontSize', 15);
% legend('Fx','Fy','Fz')
% grid on
% 
% figure;
% plot(X(60:end),Y(60:end),'LineWidth',1.5)
% xlabel('X (mm)','FontSize', 14);
% ylabel('Y (mm)','FontSize', 14);
% title('Trajectory','FontSize', 15);
% grid on

figure;
plot(time(80:end),Z(80:end),'LineWidth',1.5)
xlabel('time (sec)','FontSize', 14);
ylabel('Z (mm)','FontSize', 14);
title('Variation of Z','FontSize', 15);
findpeaks(Z(80:end),time(80:end),'MinPeakProminence',4,'Annotate','extents')
xlabel('time (sec)','FontSize', 14);
ylabel('Z (mm)','FontSize', 14);
title('Variation of Z','FontSize', 15);
grid on


