% CORDIC - Vectoring-Mode
% Betrag und Phase eines Vektors berechnen
% Exercise 20.2

clear all
close all

% Benutzereingaben abfragen
fprintf('CORDIC (Vectoring-Mode)\n=======================\n');
xs = input('Startposition x-Wert: ');
ys = input('Startposition y-Wert: ');
n  = input('Iterationen         : ');

% Wertetabellen berechnen
idx    = 0:(n-1);       % Index Vektor
alphai = ???            % Winkelschritte
ki     = ???            % Korrekturfaktor pro Einzelschritt
k      = ???            % Gesamtkorrekturfaktor


% Speicherplatz für Iterationen reservieren
x = [xs zeros(1,n)];
y = [ys zeros(1,n)];
z = ???

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

% Endposition, Betrag und Phase ausgeben
fprintf('\nEndposition: (x,y) = (%d,%d)',x(end),y(end));
fprintf('\n|(%d,%d)| = %d',x(1),y(1),x(end));
fprintf('\nangle{(%d,%d)} = %d°\n\n',x(1),y(1),z(end)*180/pi);

% Endposition zeichnen
plot(x(end),y(end),'*')
xl = 0:(x(end)/100):x(end);
yl = 0:(y(end)/100):y(end);
plot(xl,yl,'r');

angs = angle(x(1)+j*y(1));
if angs > 0
    t = angs:-0.01:0;
else
    t = angs:0.01:0;
end
plot(sqrt(x(1)^2+y(1)^2)*cos(t),sqrt(x(1)^2+y(1)^2)*sin(t),'r');
hold
