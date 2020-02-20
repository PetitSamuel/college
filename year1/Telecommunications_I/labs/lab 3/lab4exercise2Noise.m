[notes,fs] = audioread('exercise2_piece.wav');

%sound(notes, fs);
% playing OG sound

N = 2^ceil(log2(length(notes))) ;
newX = -fs/2:fs/N:fs/2-fs/N;

subplot(3,1,1);
aMS = ammod(notes, 30000, fs);
aMSnoise = aMS + (0.01 * randn(size(notes)));
f1=fftshift(fft(aMS,N));  
%MOST?
demod = amdemod(aMSnoise, 30000, fs);
plot(newX, abs(f1));

%AM w/ noise sound
% WORST
%sound(demod, fs);

%Modulate the signal with FM at 30KHz with a freq_dev value of 20KHz
subplot(3,1,2);
FMS = fmmod(notes, 30000, fs, 20000);
FMSnoise = FMS +(0.01 * randn(size(notes)));
f2=fftshift(fft(FMS,N));
plot(newX, abs(f2));

demodFM = fmdemod(FMSnoise, 30000, fs, 20000);
%2nd WORST/LEAST?
%FM w/ noise dev frq 20K
%sound(demodFM, fs);
%plot(newX, abs(f2));

%2ND MOST?
subplot(3,1,3);
FMS2 = fmmod(notes, 30000, fs, 50000);
noiseFMS2 = FMS2 +(0.01 * randn(size(notes)));
demodFM2 = fmdemod(noiseFMS2, 30000, fs, 50000);
f3=fftshift(fft(FMS2,N));
plot(newX, abs(f3));
%FM w/ noise frq dev 50K
%sound(demodFM2, fs);
% LEAST NOISE
