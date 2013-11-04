load correlationDetect


plot(detect_stat{1}(1:40000))
hold on
plot(detect_list_post(find(detect_list_post<40000)),zeros(size(find(detect_list_post<40000))),'rx')
xlabel('Samples')
ylabel('Magnitude')
title('Correlation detector results')

set(gcf,'PaperSize',[18 10],'PaperPosition',[-1 0 20.4 10.1])
print -dpdf correlationDetect