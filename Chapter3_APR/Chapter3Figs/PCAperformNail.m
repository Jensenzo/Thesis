bar([correct_mv(end:-1:1,13) wrong_mv(end:-1:1,13) ones(size(correct_mv(end:-1:1,13)))-correct_mv(end:-1:1,13)-wrong_mv(end:-1:1,13)],'stack')
%%
set(gcf,'PaperSize',[20 10],'PaperPosition',[0.15 0 20 10.1])
xlabel('Number of components')
ylabel('Ratio of all taps')
title('PCA type algorithm performance with nail data')
print -dpdf PCAperformNail
