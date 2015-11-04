% CORDIC - Rotation-Mode
% Drehung eines Vektor-Zeigers
% Exercise 20.1

clear all
close all

% Benutzereingaben abfragen
fprintf('CORDIC (Rotation-Mode)\n======================\n');
xs = input('Startposition x-Wert: ');
ys = input('Startposition y-Wert: ');
zs = input('Drehwinkel (Grad)   : ');
n  = input('Iterationen         : ');
zs = pi/180*zs;

% Wertetabellen berechnen
idx    = 0:(n-1);       % Index Vektor
alphai = ???            % Winkelschritte
ki     = ???            % Korrekturfaktor pro Einzelschritt
k      = ???            % Gesamtkorrekturfaktor

% Speicherplatz für Iterationen reservieren
x = [xs zeros(1,n)];
y = [ys zeros(1,n)];
z = [zs zeros(1,n)];

% Startposition zeichnen
figure(1)
plot(x(1),y(1),'*')
grid
set(gca,'DataAspectRatioMode',   'manual', ...
        'DataAspectRatio',       [1 1 1], ...
        'PlotBoxAspectRatioMode','manual', ...
        'PlotBoxAspectRatio',    [1 1 1]);
axis([-20,20,-20,20])
hold
xl = 0:(x(1)/100):x(1);
yl = 0:(y(1)/100):y(1);
plot(xl,yl,'r');
pause

% CORDIC-Schleife
for i = 1:n
    
    % Vorzeichen-Check
    if ???
        ???
    else
        ???
    end
    
    % Iterationsgleichungen
    x(i+1) = ???
    y(i+1) = ???
    z(i+1) = ???
    
    % Aktuelle Position zeichnen
    plot(x(i),y(i),'*')    
    pause(.5)
end

% Abschlussskalierung
x(end) = ???
y(end) = ???

% Endposition und tatsächlichen Drehwinkel ausgeben
fprintf('\nEndposition: (x,y) = (%d,%d)',x(end),y(end));
fprintf('\nRotationswinkel: z = %d°\n\n',(z(1)-z(n))*180/pi);

% Endposition zeichnen
plot(x(end),y(end),'*')
xl = 0:(x(end)/100):x(end);
yl = 0:(y(end)/100):y(end);
plot(xl,yl,'r');

angs = angle(x(1)+j*y(1));
ange = angle(x(end)+j*y(end));
if ange > angs
    t = angs:0.01:ange;
else
    t = angs:0.01:ange+2*pi;
end
plot(sqrt(x(1)^2+y(1)^2)*cos(t),sqrt(x(1)^2+y(1)^2)*sin(t),'r');
hold
