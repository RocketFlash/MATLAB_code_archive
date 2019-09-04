function  plotConfig2d(matrix,numJoints)
combos = nchoosek(1:numJoints,2);
m = size(combos,1);

w = floor(sqrt(m));
h = ceil(m/w);

for i = 1:size(combos,1)
    subplot(w,h,i)
    plot(matrix(:,combos(i,1)),matrix(:,combos(i,2)),'*b');
    grid on
    axis square 
    xlim([0,2*pi])
    ylim([0,2*pi])
    xlabel(strcat('q',num2str(combos(i,1)),'(rad)'),'FontSize',14)
    ylabel(strcat('q',num2str(combos(i,2)),'(rad)'),'FontSize',14)
end

end

