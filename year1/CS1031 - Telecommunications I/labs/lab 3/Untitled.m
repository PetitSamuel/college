clear all
N = 16384
[notes,fs] = audioread('notes.wav');
%(plot(notes))
print(gcf, '-dpdf', 'soundWave.pdf');
