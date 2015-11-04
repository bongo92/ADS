%use the fplot command
%consider the grid, the axis labels and the title
x=linspace(-4*pi,4*pi,1000);
y=sin(x)./x; 
figure;
    plot(x,y);  
    grid on;
    title('si-Funktion');
    ylabel('si(x)');
    xlabel('x');
    axis([-4*pi, 4*pi,-0.4,1.2]);
figure;
    fplot('sin(x)/x', [-4*pi,4*pi,-0.4,1.2]);
    grid on;
    title('si-Funktion');
    ylabel('si(x)');
    xlabel('x');
    axis([-4*pi, 4*pi,-0.4,1.2]);
