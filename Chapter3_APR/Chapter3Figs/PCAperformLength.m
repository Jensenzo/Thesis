%create performance plot for ML MAP

bar(templateVec,[correct_mv(:,13) min(ones(50,1)-correct_mv(:,13),wrong_mv(:,13)) (ones(size(correct_mv(:,13)))-correct_mv(:,13)-min(ones(50,1),wrong_mv(:,13)))],'stack')
%%

set(gcf,'PaperSize',[19 10],'PaperPosition',[-0.4 0 20 10.1])
xlabel('Length of template [samples]')
ylabel('Ratio of all taps')
title('PCA type algorithm performance')

print -dpdf PCAperformLength