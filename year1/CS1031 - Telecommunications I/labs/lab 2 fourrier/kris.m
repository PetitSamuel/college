count=1;
for z = [1,3,5,10,50,500]
    subplot(3,2,[count]);
    title("Approximation with "+z+" sine functions");
    hold on;
    x=0:0.5:2;
    k=1;F=0;
    for i = 1:z
        hold on;
        y = (4/pi)*sin(2*pi*x*k)/k;
        Y =(4/pi)/k;
        stem(i,Y,'b');
        k=k+2;
    end
    count=count+1;
end