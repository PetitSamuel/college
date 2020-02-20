x= -1: 0.01: 1;
count = 0;
yKeep = sawtooth(2 * pi * (x + 0.25), 0.5);
for i = [1, 2, 3, 5, 10, 50]
      count =count + 1;
      ax = subplot(3,2, count);
      y = 0;
      for j = 0 : i
         y = y + ((-1)^j * (sin(2 * pi * (2 * j + 1)* x)/ (2 * j + 1)^2));
      end
      y = y * ( 8 / pi^2 );
      hold on;
      plot(ax, x,yKeep, 'r');
      plot(ax, x, y, 'b');
      grid on;
      title(ax, "Approximation with " + i + " sine functions");
end
print(gcf, '-dpdf', 'secondPlot.pdf');
