
hold on
step = 12;
load('case4.mat');
Y=Acc1(:,2);
plot(Y,'*r');
YY = smooth(Y,step);
plot(YY,'b');

sigma = zeros(1,length(Y));
k=1;
for i=ceil(step/2):length(Y)-ceil(step/2)+1
    for j=-ceil(step/2)+1:ceil(step/2)-1
        sigma(k) = sigma(k) + (Y(i+j)-YY(i))^2;
    end
    sigma(k) = sqrt(sigma(k)/(step-1));
    k=k+1;
end
averSigma = sum(sigma)/length(sigma);    
SEM = averSigma/sqrt(step);               
Yup = YY(ceil(step/2):length(Y)-ceil(step/2))+(1.96*SEM);
Ybot = YY(ceil(step/2):length(Y)-ceil(step/2))-(1.96*SEM);

plot(ceil(step/2):length(Yup)+ceil(step/2)-1,Yup);
plot(ceil(step/2):length(Ybot)+ceil(step/2)-1,Ybot);
grid on
legend('data','moving average','upper boud of confidence interval','lower boud of confidence interval');
