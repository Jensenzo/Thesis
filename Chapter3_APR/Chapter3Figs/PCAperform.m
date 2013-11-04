set(gcf,'PaperSize',[20 10],'PaperPosition',[0.15 0 20 10.1])
xlabel('Number of components')
ylabel('Ratio of all taps')
title('PCA type algorithm performance')
print -dpdf PCAperform
