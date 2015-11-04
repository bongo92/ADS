% FIR - filter design using windowing method: 
% Exercise 13.1
% 1) rectangular window 
% 2) kaiser window
% 3) hamming window

clear all;
close all

fs = 20e3;                          % sampling frequency

% tolerance scheme
f_pass = 3.4e3;                     % passband cutoff frequency
f_stop = 4e3;                       % stopband cutoff frequency
Omega_pass = ???;  	                % passband cutoff radian frequency
Omega_stop = ???;   	            % stopband cutoff radian frequency

Delta_1 = ???;  			        % passband tolerance
Delta_2 = ???; 			            % stopband tolerance (20 log(Delta_2/1) = -45 dB

% filter order and design parameter beta for Kaiser window
Delta_min = ???;
DeltaOmega = ???;
a = ???;
if ???
  beta = ???;
elseif ???
  beta = ???;
else
  beta = ???;
end
D = ???;
N = ???;
% select even filter order
N = ceil(N);
if rem(N,2) ~= 0
  N = N + 1;
end
N = N + 2; % compensate prediction uncertainty
fprintf('filter order N = %g  :  beta = %g\n',N,beta);

% Filter Design
% radian corner frequency
Omega_0 = ???;

% impulse response (causal, order N)
n = -N/2:N/2;
h = ???;

% frequency response
M = 1024;
[H,Omega] = freqz(???,???,???);

% Kaiser windowing
wK = kaiser(???,???);
hK = h.*wK'; % modified impulse response
% see MATLAB function hK = fir1(N,Omega_C,kaiser(N+1,beta));

% frequency response
[HK,f] = freqz(???,???,???);

% Hamming windowing
wH = hamming(???);
hH = h.*wH'; % modified impulse response
% see MATLAB function hH = fir1(N,Omega_C);

% frequency response
[HH,f] = freqz(???,???,???);

% ------------------------------------------------------ graphics
% windows
figure(1), clf
subplot(3,1,1)
n = 0:N;
stem(n,ones(1,N+1)), grid % rectangular
xlabel('n \rightarrow'), ylabel('w_{rec}[n] \rightarrow')
axis([0 N 0 1]);
subplot(3,1,2)
stem(n,wK), grid % Kaiser
xlabel('n \rightarrow'), ylabel('w_K[n] \rightarrow')
axis([0 N 0 1]);
subplot(3,1,3)
stem(n,wH), grid % Hamming
xlabel('n \rightarrow'), ylabel('w_H[n] \rightarrow')
axis([0 N 0 1]);
pause

% impulse responses
figure(2), clf
subplot(3,1,1)
stem(n,h), grid % classical Fourier
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
axis([0 N -.2 .5]);
subplot(3,1,2)
stem(n,hK), grid % Kaiser
xlabel('n \rightarrow'), ylabel('h_K[n] \rightarrow')
axis([0 N -.2 .5]);
subplot(3,1,3)
stem(n,hH), grid % Hamming
xlabel('n \rightarrow'), ylabel('h_H[n] \rightarrow')
axis([0 N -.2 .5]);
pause

% frequency response
% tolerance scheme for display
TSu = (1+Delta_1)*ones(1,M); % upper tolerance border
TSl = zeros(1,M);           % lower tolerance border
for k=1:M
  if k <= Omega_pass/pi*M
    TSl(k) = 1-Delta_1;
  end
  if k >= Omega_stop/pi*M
    TSu(k) = Delta_2;
  end
end
figure(3), clf
subplot(3,1,1), plot(Omega/pi,abs(H),Omega/pi,TSu,'r',Omega/pi,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega /\pi \rightarrow')
ylabel('|H(\Omega)| \rightarrow')
subplot(3,1,2), plot(Omega/pi,abs(HK),Omega/pi,TSu,'r',Omega/pi,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega /\pi \rightarrow')
ylabel('|H_K(\Omega)| \rightarrow')
subplot(3,1,3), plot(Omega/pi,abs(HH),Omega/pi,TSu,'r',Omega/pi,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega /\pi \rightarrow')
ylabel('|H_H(e^\Omega)| \rightarrow')
pause

% Plot in Dezibels
figure(4), clf
subplot(3,1,1), plot(Omega/pi,20*log10(abs(H)),Omega/pi,20*log10(TSu),'r',...
Omega/pi,20*log10(TSl+1e-12),'r')
axis([0 1 -80,5]); grid
xlabel('\Omega /\pi \rightarrow')
ylabel('20*log|H(\Omega)| [dB] \rightarrow')
subplot(3,1,2), plot(Omega/pi,20*log10(abs(HK)),Omega/pi,20*log10(TSu),'r',...
Omega/pi,20*log10(TSl+1e-12),'r')
axis([0 1 -80,5]); grid
xlabel('\Omega /\pi \rightarrow')
ylabel('20*log|H_K(\Omega)| [dB] \rightarrow')
subplot(3,1,3), plot(Omega/pi,20*log10(abs(HH)),Omega/pi,20*log10(TSu),'r',...
Omega/pi,20*log10(TSl+1e-12),'r')
axis([0 1 -80,5]); grid
xlabel('\Omega /\pi \rightarrow')
ylabel('20*log|H_H(e^\Omega)| [dB] \rightarrow')
% end