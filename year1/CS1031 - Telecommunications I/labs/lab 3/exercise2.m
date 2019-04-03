clear all
load ('array.mat')
%(plot(y))
fs = 1000;
N = 1024
S=fftshift(abs(fft(y,N))) 
newX = -fs/2:fs/N:fs/2-fs/N
plot(newX, S)

print(gcf, '-dpdf', 'secondPlotFFT.pdf');
