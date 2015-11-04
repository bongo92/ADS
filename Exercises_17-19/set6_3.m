% ######################### Sampling rate conversion #########################
%
%   HM, 18.09.2002

% ################################ Parameters ################################

fa1 = 14e3;     % Original sampling rate
T1 = 1/fa1;     % Original sampling time
f0 = 0.5e3;     % Signal frequency
I = 3;          % Interpolation factor
R = 4;          % Decimation factor
fa2 = fa1*I/R;  % Sampling rate after decimation
T2 = T1*R/I;    % Sampling time after dcimation

% Signal generation

K = 40;                                 % Number of samples
t1 = 0:T1:(K-1)*T1;
x = cos(2*pi*f0*t1).*hanning(K).';


% Sampling rate conversion

[y,b] = resample(x,I,R);


% ################################# Graphics #################################

% Time domain signals
figure(1), clf
stem(t1,x,'o'), grid, hold
axis([0,K*T1,-1.2,1.2]), pause
L = length(y);
t2 = 0:T2:(L-1)*T2;
stem(t2,y,'ro')
xlabel('Time [s]')
ylabel('x, y')
axis([0,K*T1,-1.2,1.2]), hold, pause


% Frequency domain graphics
figure(2), clf
subplot(211)
KK = 4*K;
df = 1/(KK*T1);
X = fft(x,KK);
XX = [X X X X];
f = -2*KK*df:df:(2*KK-1)*df;
plot(f,abs(XX)), grid
xlabel('f [Hz]')
ylabel('|X_s(f)|')
axis([-21e3,21e3,0,12])
pause
subplot(212)
LL = 4*L;
f = -2*LL*df:df:(2*LL-1)*df;
Y = fft(y,LL);
YY = [Y Y Y Y];
plot(f,abs(YY)), grid
xlabel('f [Hz]')
ylabel('|Y_s(f)|')
axis([-21e3,21e3,0,12])
pause


% Filter frequecy response
figure(3), clf
[H,f] = freqz(b,1,1024);
subplot(211)
plot(f, abs(H)), grid
xlabel('f [Hz]')
ylabel('|H_s(f)| [linear]')
subplot(212)
plot(f, 20*log10(abs(H))), grid
xlabel('f [Hz]')
ylabel('|H_s(f)| [dB]')