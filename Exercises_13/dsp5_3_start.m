% FIR - (low pass) filter design using remez-algorithm
%Exercise 13.2

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


% estimation of filter order for Chebyshev approximation
dev = ???;            % deviation
f = ???;    % frequency bands
a = [1 0];                          % amplitudes
[N,f0,a0,w] = firpmord(f,a,dev,fs);
N = N + 2; % compensate for estimation error
fprintf('filter order N = %g\n',N);

% filter design by Remez algorithm
h  =  firpm(???,???,???,???); % impulse response

% frequency response
M = 2048;               % number of frequency samples
[H,Omega] = freqz(???,???,???);

% ------------------------------------------------------ graphics
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
FIG1 = figure('Name','dsplab10_1: Chebyshev FIR lowpass filter design with Remez algorithm',...
  'NumberTitle','off','Units','normal','Position',[.54 .40 .45 .55]);
% impulse responses
subplot(3,1,1)
n = 0:N;
stem(n,h), grid
xlabel('n \rightarrow'), ylabel('h[n] \rightarrow')
axis([0 N -.2 .5]);
% frequency response
subplot(3,1,2), plot(Omega/pi,abs(H),Omega/pi,TSu,'r',Omega/pi,TSl,'r')
axis([0 1 0 1.2]); grid
xlabel('\Omega /\pi \rightarrow')
ylabel('|H(\Omega)| \rightarrow')
% frequency response in dB
subplot(3,1,3), plot(Omega/pi,20*log10(abs(H)),Omega/pi,20*log10(TSu),'r',...
Omega/pi,20*log10(TSl+1e-12),'r')
axis([0 1 -80 5]); grid
xlabel('\Omega /\pi \rightarrow')
ylabel('20*log|H(\Omega)| [dB] \rightarrow')
% end