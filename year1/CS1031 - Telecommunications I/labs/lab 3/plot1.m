clear all
f=10        % frequency
fs=10*f;    % sample Freq
time = 2    % time for 20 cycles
t=[0:1/fs:time-1/fs]   
y=sin(2*pi*f*t); 

i = 1
for N = [64, 128, 256]
    subplot(3,1, i)
    hold on
    newX=-fs/2:fs/N:fs/2-fs/N;
    F=fftshift(fft(y,N));         
    plot(newX, abs(F));
    i = i + 1
    title("Plot with N = " + N)
end
