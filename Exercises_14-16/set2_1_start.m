% ########################## set2_1.m ###########################
% FIR low pass filter optimum equiripple design(Chebyshev 
% approximation/Remez algorithm) with quantized coefficients 
% Exercise 15

clear all
close all

% Input of lowpass filter tolerance scheme
fprintf('set2_1 \n')
fprintf(' \n')
fprintf('normalized frequencies in [0,1] \n')   % tolerance scheme
OmegaP = input('passband cutoff frequency .... (0.2) : ');
RP = input('passband ripple in dB ........ (0.2) : ');
OmegaS = input('stopband cutoff frequency .... (0.3) : ');
RS = input('stopband attenuation in dB .... (40) : ');
B = input('word length B in bits .......... (8) : ');

if isempty(OmegaP)
  OmegaP = .2;
end
if isempty(RP)
  RP = 0.2;
end
DeltaP = (10^(RP/20) - 1) / (10^(RP/20) + 1);
if isempty(OmegaS)
  OmegaS = .3;
end
if isempty(RS)
  RS = 40;
end
DeltaS = 10^(-RS/20);
if isempty(B)
  B = 8;
end
fprintf('\n')

% Filter design (Remez algorithm)
dev = [DeltaP DeltaS];
f = [OmegaP OmegaS];
fs = 2;
m = [1 0];
[n,f0,m0,w] = remezord(f,m,dev,fs);
n = n + 2;              % compensate for estimation error

h =  remez(n,f0,m0,w);  % impulse response

% Quantization of the filter coefficients to B bits
LSB = ???;
if max(abs(h))>1-LSB
  fprintf('Error: coefficient overflow')
end
hq = ???;  % quantized impulse response
hd = h - hq;            % impulse response error

% Output of designed and quantized impulse response (coefficients)
fprintf('impulse response\n')
fprintf('index : design : quantized : error\n')
for k=1:length(h)
  fprintf('%4i    %7.4f   %7.4f   %7.4f\n',k,h(k),hq(k),hd(k))
end
fprintf('\n')

% Calculation of the frequency response(s)
M = 1024;
[H,f] = freqz(h,1,M);
[Hq,f] = freqz(hq,1,M);
[Hd,f] = freqz(hd,1,M);

% Maximum frequency deviation
MAX = max(abs(H-Hq));
MAX_limit = ???;
fprintf('maximum deviation of magnitude of frequency response\n')
fprintf('and upper error bound: %g <= %g\n',MAX,MAX_limit)
fprintf(' \n');

% ##################################### Graphics #######################################

FIG1 = figure('Name','set2_1 : FIR filter design with quantized coefficients',...
    'NumberTitle','off','Units','normal','Position',[.54 .40 .45 .55]);

% Impulse responses (designed and quantized)
subplot(2,2,1), 
n = 0:length(h)-1;
stem(n,h),grid, hold
stem(n,hq,'g'), hold
axis([0 length(h)-1 -.1 .5]);
xlabel('n \rightarrow'), ylabel('h[n], h_Q[n] \rightarrow')

% Frequency response(s) with tolerance scheme
TSu = (1+DeltaP)*ones(1,M); % upper limit
TSl = zeros(1,M);    % lower limit
for k=1:M
  if k <= OmegaP*M
    TSl(k) = 1-DeltaP;
  end
  if k >= OmegaS*M
    TSu(k) = DeltaS;
  end
end
fn = f/pi;
subplot(2,2,2), plot(fn,abs(H),fn,abs(Hq),fn,TSu,'r',fn,TSl,'r')
axis([0 1 -.05 1.2]); grid
xlabel('\Omega / \pi \rightarrow'), ylabel('H(\Omega) \rightarrow')

% Frequency response(s) in dB
subplot(2,2,3), plot(fn,20*log10(abs(H)),fn,20*log10(abs(Hq)),...
    fn,20*log10(abs(TSu)),'r',fn,20*log10(abs(TSl)),'r'), grid
axis([0 1 20*log10(DeltaS)-30 5])
xlabel('\Omega / \pi \rightarrow'), ylabel('20log(|H(\Omega)|), 20log(|H_Q(\Omega)|) \rightarrow')

% Quantization error in the frequency domain
subplot(2,2,4), plot(fn,abs(Hd)), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|\DeltaH(\Omega)| \rightarrow')
title(['error bound: ', num2str(MAX_limit)])
% end
