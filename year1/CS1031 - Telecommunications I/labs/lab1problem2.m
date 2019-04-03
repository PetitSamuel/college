x = -2*pi: 0.01 : 2*pi;
y = sin(x) + 0.2 * randn(size(x));
plot(x, y, 'b');
