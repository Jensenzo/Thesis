figure1 = figure('PaperType','<custom>','PaperSize',[20 10],'PaperPosition',[0.15 0 20 10.1])
axes1 = axes('Parent',figure1,'XTick',[1 2 3 4 5 6 7 8 9 10],...
    'Position',[0.087 0.135 0.775 0.78]);

bar1 = bar([correct_mv(end:-1:1,13) wrong_mv(end:-1:1,13) ones(size(correct_mv(end:-1:1,13)))-correct_mv(end:-1:1,13)-wrong_mv(end:-1:1,13)],'stack')
%%
set(bar1(1),...
    'FaceColor',[0.831372559070587 0.815686285495758 0.7843137383461],...
    'DisplayName','Correct classification');
set(bar1(2),...
    'FaceColor',[0.24705882370472 0.24705882370472 0.24705882370472],...
    'DisplayName','Missed detection');
set(bar1(3),...
    'FaceColor',[0.501960813999176 0.501960813999176 0.501960813999176],...
    'DisplayName','Misclassification');

xlim(axes1,[0.5 10.5]);
xlabel('Number of components')
ylabel('Ratio of all taps')
title('PCA type algorithm performance')

% Create legend
legend1=legend(axes1,'show');
set(legend1,...
    'Position',[0.750574043577721 0.804409029763818 0.226722925457102 0.164408310749774]);



print -dpdf PCAperform_SN-SN
