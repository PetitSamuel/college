clear all
N = 16384
[notes,fs] = audioread('notes.wav');
newX = -fs/2:fs/N:fs/2-fs/N
n1 = notes(1:6720); % first note
n2 = notes(6720:length(notes))

%note1
subplot(2,1,1);
f1=fftshift(fft(n1,N));  
sound(n1, fs);
plot(newX, abs(f1));

% B1 61.74

%note2
subplot(2,1,2);
f2=fftshift(fft(n2,N));  
sound(n2, fs);
plot(newX, abs(f2));
%F#2/Gb2 92.50

print(gcf, '-dpdf', 'thirdPlotFFT.pdf');
    