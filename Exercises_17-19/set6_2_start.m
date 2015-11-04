% ################################ Decimation ############################
% Exercise 18
%   HM, 18.09.2002

% ################################ Parameters ################################

sigma_n = 0.3;    % Noise variance
fa1 = 14e3;     % Original sampling rate
T1 = 1/fa1;     % Original sampling time
f0 = 0.5e3;     % Signal frequency
R = 4;          % Decimation factor
fa2 = fa1/R;    % Sampling rate after decimation
T2 = T1*R;      % Sampling time after dcimation

% ############################## Signal generation ###########################

K = 160;                                 % Number of samples of original digital signal

OS_an = 16;                             % Oversampling for quasi analog representation
t = 0:T1/OS_an:(OS_an*K-1)*T1/OS_an;
s_an = cos(2*pi*f0*t).*hanning(K*OS_an).';    % Quasi analog signal

t1 = 0:T1:(K-1)*T1;
s = s_an(1:OS_an:end);                  % Original digital signal
n = sigma_n*randn(1,K);                 % Noise sequence
x = s + n;                              % Disturbed signal


% ############################ Decimation method 1 ###########################
% ########################### Dropping samples only ##########################

y1 = ???;


% ############################ Decimation method 2 ###########################
% ############################# Resample-function ############################

[y2,b2] = ???;


% ##################### Decimation method 2 in more detail ###################
% ######################## TP-filter + dropping samples ######################

% Filtering
N = length(???)-1;   % FIR filter order
w3 = conv(???,???);
w3 = w3(N/2+1:end-N/2);

% Dropping samples
y3 = ???;

% Noisepower of dezimated signals / SNRs
y = s(1:R:end);
L = length(y);
e1 = y-y1;
e2 = y-y2;
e3 = y-y3;
Py = ???;
Pe1 = ???;
Pe2 = ???;
Pe3 = ???;
SNR1 = ???
SNR2 = ???
SNR3 = ???


% ################################# Graphics #################################

% Time domain signals
figure(1), clf
subplot(411)
plot(t,s_an,'k:'), grid, hold
stem(t1,s,'o')
xlabel('Time [s]')
ylabel('s')
axis([0,K*T1,-  2,2]), hold, pause
subplot(412)
plot(t,s_an,':'), grid, hold
stem(t1,x,'o')
xlabel('Time [s]')
ylabel('x = s + n')
axis([0,K*T1,-2,2]), hold, pause
subplot(414)
plot(t,s_an,':'), grid, hold
t2 = 0:T2:(K/R-1)*T2;
stem(t2,y1,'ro')
xlabel('Time [s]')
ylabel('y1')
axis([0,K*T1,-2,2]), hold, pause


% Time domain signals 2
figure(2), clf
subplot(411)
plot(t,s_an,'k:'), grid, hold
stem(t1,s,'o')
xlabel('Time [s]')
ylabel('s')
axis([0,K*T1,-2,2]), hold, pause
subplot(412)
plot(t,s_an,':'), grid, hold
stem(t1,x,'o')
xlabel('Time [s]')
ylabel('x = s + n')
axis([0,K*T1,-2,2]), hold, pause
subplot(414)
plot(t,s_an,':'), grid, hold
t2 = 0:T2:(K/R-1)*T2;
stem(t2,y2,'ro')
xlabel('Time [s]')
ylabel('y2')
axis([0,K*T1,-2,2]), hold, pause

% Time domain signals 3
figure(3), clf
subplot(411)
plot(t,s_an,'k:'), grid, hold
stem(t1,s,'o')
xlabel('Time [s]')
ylabel('s')
axis([0,K*T1,-1.2,1.2]), hold, pause
subplot(412)
plot(t,s_an,':'), grid, hold
stem(t1,x,'o')
xlabel('Time [s]')
ylabel('x = s + n')
axis([0,K*T1,-2,2]), hold, pause
subplot(413)
plot(t,s_an,':'), grid, hold
stem(t1,w3,'o')
xlabel('Time [s]')
ylabel('w3')
axis([0,K*T1,-2,2]), hold, pause
subplot(414)
plot(t,s_an,':'), grid, hold
t2 = 0:T2:(K/R-1)*T2;
stem(t2,y3,'ro')
xlabel('Time [s]')
ylabel('y3')
axis([0,K*T1,-2,2]), hold, pause


% Frequency domain graphics
figure(4)
clf
subplot(411)
df = 1/(K*T1);
S = fft(s);
SS = [S S S S];
f = -2*K*df:df:(2*K-1)*df;
plot(f,abs(SS)), grid
xlabel('f [Hz]')
ylabel('|S_D(f)|'), pause
subplot(412)
X = fft(x);
XX = [X X X X];
f = -2*K*df:df:(2*K-1)*df;
plot(f,abs(XX)), grid
xlabel('f [Hz]')
ylabel('|X_D(f)|'), pause
subplot(414)
Y1 = fft(y1);
Y1Y1 = [Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1 Y1];
f = -2*K*df:df:(2*K-1)*df;
plot(f,abs(Y1Y1)), grid
xlabel('f [Hz]')
ylabel('|Y1_D(f)|'), pause

figure(5)
clf
subplot(411)
df = 1/(K*T1);
S = fft(s);
SS = [S S S S];
f = -2*K*df:df:(2*K-1)*df;
plot(f,abs(SS)), grid
xlabel('f [Hz]')
ylabel('|S_D(f)|'), pause
subplot(412)
X = fft(x);
XX = [X X X X];
f = -2*K*df:df:(2*K-1)*df;
plot(f,abs(XX)), grid
xlabel('f [Hz]')
ylabel('|X_D(f)|'), pause
subplot(413)
W3 = fft(w3);
W3W3 = [W3 W3 W3 W3];
f = -2*K*df:df:(2*K-1)*df;
plot(f,abs(W3W3)), grid
xlabel('f [Hz]')
ylabel('|W3_D(f)|'), pause
subplot(414)
Y3 = fft(y3);
Y3Y3 = [Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3 Y3];
f = -2*K*df:df:(2*K-1)*df;
plot(f,abs(Y3Y3)), grid
xlabel('f [Hz]')
ylabel('|Y3_D(f)|')



