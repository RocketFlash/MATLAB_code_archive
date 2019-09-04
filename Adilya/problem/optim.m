stri = 'percent';
enstr = '.dat';
numbs = [1,5,20,30];
hold on
for i = 1:4
    A = load(strcat(stri,num2str(numbs(i)),enstr));
    T = A(:,1);
    ChiExperiment = A(:,2);
    k0 = [1,1,1];
    fun = @(k) (k(1) + k(2)./(T-k(3))) - ChiExperiment;
    OptParam = lsqnonlin(fun,k0);
    t = linspace(T(1),T(end));
    ChiTeor = OptParam(1) + OptParam(2)./(t-OptParam(3));
    plot(T,ChiExperiment,'.r',t,ChiTeor,'b');
    grid on
    
    Chi0 = strcat('Chi0=',num2str(OptParam(1)));
    C = strcat('C=',num2str(OptParam(2)));
    teta = strcat('teta=',num2str(OptParam(3)));
    disp(strcat(Chi0,',',C,',',teta));
end

