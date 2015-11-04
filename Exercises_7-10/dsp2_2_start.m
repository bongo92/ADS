% ******************************* Total Harmoic Distortion Measurement **********************************
% *************************************************************************************

clear all
close all

% Parameter of the periodic input signal x(t)
f0 = 1e3;                   % Frequency of the input signal
T0 = 1/f0;                 % Period of the input signal

% Creating the input signal and plotting
fs = 32e3;
Ts = 1/fs;
t = 0:Ts:3*T0-Ts;
x = cos(2*pi*f0*t);

figure(1), clf
subplot(211)
plot(t,x), grid
xlabel('t [s]')
ylabel('y(t)')


% Transmission over a non-linear characteristic (amplifier)
p = 1;
y = real(x./( (1+x.^(2*p)).^(1/(2*p)) ));

subplot(212)
plot(t,y), grid
xlabel('t [s]')
ylabel('x(t)')


figure(2), clf
a=-1.5:0.01:1.5;
b = (a./( (1+a.^(2*p)).^(1/(2*p)) ));
plot(a,b), grid



% ********************************** SPECTRAL ANALYSIS ************************************
%***************************************************************************************

% DFT Parameter
T = T0;                 % Measurement time
% Ts & fs: see above
N = T/Ts;               % Number of samples
df = 1/T;               % Distance between two frequency points after DFT

% Spectral analysis of the input signal
x = x(1:T0/Ts);
X = fft(x);
cx = 1/N*fftshift(X);

% Spectral analysis of the output signal
y = y(1:T0/Ts);
Y = fft(y);
cy = 1/N*fftshift(Y);

f = (-N/2*df:df:(N/2-1)*df);
figure(3), clf
subplot(211)
title('Spektrum von x[n]')
stem(f,real(cx)), grid
axis([-max(abs(f)),max(abs(f)),-max(abs(cx)),max(abs(cx))])
ylabel('real(c_k)')
subplot(212)
stem(f,imag(cx)), grid
xlabel('f [Hz]')
ylabel('imag(c_k)')
axis([-max(abs(f)),max(abs(f)),-max(abs(cx)),max(abs(cx))])
%pause

f = (-N/2*df:df:(N/2-1)*df);
figure(4), clf
subplot(211)
title('Spektrum von y[n]')
stem(f,real(cy)), grid
axis([-max(abs(f)),max(abs(f)),-max(abs(cy)),max(abs(cy))])
ylabel('real(c_k)')
subplot(212)
stem(f,imag(cy)), grid
xlabel('f [Hz]')
ylabel('imag(c_k)')
axis([-max(abs(f)),max(abs(f)),-max(abs(cy)),max(abs(cy))])
%pause

% Gleichwert / equivalent value
X_DC = 1/N*X(1);
Y_DC = 1/N*Y(1);

% Effektivwert des Wechselanteils / RMS value of the AC component 
Xk = sqrt(2)/N*abs(X(2:N/2));
Xko = sqrt(2)/N*abs(X(3:N/2));
X_AC = sqrt(sum(Xk.^2));
X_o = sqrt(sum(Xko.^2));


Yk = sqrt(2)/N*X(2:N/2);
Yko = sqrt(2)/N*abs(Y(3:N/2));
Y_AC = sqrt(sum(Yk.^2));
Y_o = sqrt(sum(Yko.^2));


% Effektivwert / RMS value
X_RMS = sqrt((X_DC^2)+(X_AC^2));
Y_RMS = sqrt((Y_DC^2)+(Y_AC^2));

% Klirrfaktor /THD
Kx = X_o/X_AC;
Ky = Y_o/Y_AC;

