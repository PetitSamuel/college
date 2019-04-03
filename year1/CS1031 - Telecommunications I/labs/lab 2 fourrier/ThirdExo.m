count = 0;

for i = [1, 3, 5, 10, 50, 500]
      x= 0: 0.5: 2;
      count =count + 1;
      ax = subplot(3,2, count);
      k = 1;
      for j = 1 : i
        hold on;
        y =(4/pi)/k;
        stem(j,y, 'b');
        k=k+2;
      end
      ylim([0, 1.5]);
      title(ax, "Approximation with " + i + " sine functions");
end

print(gcf, '-dpdf', 'thirdPlot.pdf');
