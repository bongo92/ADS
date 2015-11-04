% ##################### set1_7: SNR Messungen #######################
% Exercise 14
% measurement of signal-to-quantization noise power ratio

clear all
close all

% vector of wordlengths to be investigated
B = [2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];

% linear input signal
x = ???;                                % input signal
S = ???;                                % signal power
SNR_l = zeros(size(B));
for k=1:length(B)
  xq = ???;                             % quantized signal (rounding)
  N = ???;                              % noise power
  SNR_l(k) = S/N;                       % SNR  
end

% sinusoidal input signal
n = 0:0.001:1;                          % normalized time
x = sin(2*pi*n);                        % input signal
S = ???;                                % signal power
SNR_s = zeros(size(B));
for k=1:length(B)
  xq   = ???;                           % quantized signal (rounding)
  N = ???;                              % noise power
  SNR_s(k) = S/N;                       % SNR
end

% speech signal
[x,fs,bits]=wavread('dsplab_speech');
x = x/max(abs(x));                      % scaling
S = ???;                                % signal power
SNR_speech = zeros(size(B));
for k=1:length(B)-1
  xq = ???;                             % quantized signal (rounding)
  N = ???;                              % noise power
  SNR_speech(k) = S/N;                  % SNR
end

% graphics
figure('Name','quantization SNR','NumberTitle','off');
plot(B,10*log10(SNR_l),'o',B,10*log10(SNR_s),'*',...
  B,10*log10(SNR_speech),'+')
h = legend('linear','sinusoidal','speech',4);
xlabel('word length B [bits] \rightarrow')
ylabel('SNR [dB] \rightarrow')
hold on
plot(B,10*log10(SNR_l),':',B,10*log10(SNR_s),':',...
  B,10*log10(SNR_speech),':'),grid
hold off
% end

