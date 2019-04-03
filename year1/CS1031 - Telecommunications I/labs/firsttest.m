x = -2*pi: 0.1 : 2*pi;
y = cos(x);
plot(x, y, 'k');
hold on;
y = 0.5*sin(x);
stem(x, y, 'r');


