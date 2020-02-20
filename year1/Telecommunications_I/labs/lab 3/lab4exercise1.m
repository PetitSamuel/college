clear all
subplot(3,1,1);
[notes,fs] = audioread('exercise1_piece.wav');
N = 2^ceil(log2(length(notes)));
%(plot(notes))
newX = -fs/2:fs/N:fs/2-fs/N;
f1=fftshift(fft(notes,N));  
sound(notes, fs);
plot(newX, abs(f1));
hold on 

subplot(3,1,2);
aMS = ammod(notes, 30000, fs);
f2=fftshift(fft(aMS,N));  
plot(newX, abs(f2));

hold on
subplot(3,1,3);

FMS = fmmod(notes, 30000, fs, 10000);
f3=fftshift(fft(FMS,N));  
plot(newX, abs(f3));