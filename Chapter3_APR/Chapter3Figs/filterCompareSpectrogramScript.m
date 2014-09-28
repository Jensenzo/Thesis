 data1 = data(1:200000);

b=fir1(50,0.04,'high'); %old filter
data2 = filter(b,1,data1);
nfft = 256;
overlap = 250;
win = 256;

figure
subplot(1,2,1)
[S,F,T,P] = spectrogram(data1,win,overlap,nfft,fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
shading interp
view(0,90);
xlabel('Time (Seconds)'); ylabel('Hz');


subplot(1,2,2)
[S2,F2,T2,P2] = spectrogram(data2,win,overlap,nfft,fs);
surf(T2,F2,10*log10(P2),'edgecolor','none'); axis tight;
shading interp
view(0,90);
xlabel('Time (Seconds)'); ylabel('Hz');