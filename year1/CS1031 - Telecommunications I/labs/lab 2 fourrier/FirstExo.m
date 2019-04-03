x= -1: 0.01: 1;
count = 0;
yKeep = square(2 * pi * x);
i = [1, 3, 5, 10, 50, 500];
for i = [1, 3, 5, 10, 50, 500]
      count =count + 1;
      ax = subplot(3,2, count);
      y = 0;
      k = 1;
      for j = 1 : i
          y = y + ((sin(2 * pi * k * x) / k));
          k = k + 2;
      end
      y = y * (4 / pi);
      hold on;
      ylim([-2, 2]);

      plot(ax, x,yKeep, 'r');
      plot(ax, x, y, 'b');

      title(ax, "Approximation with " + i + " sine functions");
end

print(gcf, '-dpdf', 'firstPlot.pdf');
