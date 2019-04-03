f=10
fs=20*f; 
time = 2
t=[0:1/fs:time-1/fs]
y=sin(2*pi*f*t); 

ax = subplot(2,2, 1)
hold on
plot(ax, t, y)
title(ax, "Original sin wave")

i = 2
for N = [64, 128, 256]
    ax = subplot(2,2, i)
    hold on
    newX=-fs/2:fs/N:fs/2-fs/N
    F=fftshift(abs(fft(y,N)))         
    plot(ax, newX, F)
    i = i + 1
    title(ax, "Plot with N = " + N)
end
