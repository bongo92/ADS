% Window-Functions in time and frequency domain

Nw = 64; NC = 65;               % Length of windows
N = 2048;                       % Length of fft
Omega = (0:N-1)/(N/2)*pi;       % Normalized radian frequency


FIG1 = figure('Name','Bartlett and Blackman window',...
  'NumberTitle','off');
w = ???; % Bartlett window
subplot(3,2,1), stem(0:Nw-1,w), grid
axis([0 Nw-1 0 1])
title('Bartlett')
xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft(???);
W = W/abs(W(1));
subplot(3,2,3),plot(Omega,abs(W)), grid
axis([0 pi 0 1])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (linear) \rightarrow') 
subplot(3,2,5),plot(Omega,20*log10(abs(W))), grid
axis([0 pi -120 0])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (log) \rightarrow') 

w = ???; % Blackman window
subplot(3,2,2), stem(0:Nw-1,w), grid
axis([0 Nw-1 0 1])
title('Blackman')
xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft(???);
W = W/abs(W(1));
subplot(3,2,4),plot(Omega,abs(W)), grid
axis([0 pi 0 1])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (linear) \rightarrow') 
subplot(3,2,6),plot(Omega,20*log10(abs(W))), grid
axis([0 pi -120 0])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (log) \rightarrow') 


FIG2 = figure('Name','Boxcar and Chebyshev window',...
  'NumberTitle','off');
w = ???;
subplot(3,2,1), stem(0:Nw-1,w), grid
axis([0 Nw-1 0 1])
title('boxcar')
xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft(???);
W = W/abs(W(1));
subplot(3,2,3),plot(Omega,abs(W)), grid
axis([0 pi 0 1])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (linear) \rightarrow') 
subplot(3,2,5),plot(Omega,20*log10(abs(W))), grid
axis([0 pi -120 0])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (log) \rightarrow') 

w = chebwin(NC,???);
subplot(3,2,2), stem(0:NC-1,w), grid
axis([0 NC 0 1])
title('Chebyshev')
xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft(???);
W = W/abs(W(1));
subplot(3,2,4),plot(Omega,abs(W)), grid
axis([0 pi 0 1])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (linear) \rightarrow') 
subplot(3,2,6),plot(Omega,20*log10(abs(W))), grid% semilogy(Omega,abs(W)), grid
axis([0 pi -120 0])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (log) \rightarrow') 


FIG3 = figure('Name','Hamming and Hann(ing) window',...
  'NumberTitle','off');
w = ???;
subplot(3,2,1), stem(0:Nw-1,w), grid
axis([0 Nw-1 0 1])
title('Hamming')
xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft(???);
W = W/abs(W(1));
subplot(3,2,3),plot(Omega,abs(W)), grid
axis([0 pi 0 1])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (linear) \rightarrow') 
subplot(3,2,5),plot(Omega,20*log10(abs(W))), grid
axis([0 pi -120 0])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (log) \rightarrow') 

w = ???;
subplot(3,2,2), stem(0:Nw-1,w), grid
axis([0 Nw-1 0 1])
title('Hann(ing)')
xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft(???);
W = W/abs(W(1));
subplot(3,2,4),plot(Omega,abs(W)), grid
axis([0 pi 0 1])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (linear) \rightarrow') 
subplot(3,2,6),plot(Omega,20*log10(abs(W))), grid
axis([0 pi -120 0])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (log) \rightarrow') 


FIG4 = figure('Name','Kaiser and triangular window','NumberTitle','off');
w = kaiser(???,???);
subplot(3,2,1), stem(0:Nw-1,w), grid
axis([0 Nw-1 0 1])
title('Kaiser')
xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft(???);
W = W/abs(W(1));
subplot(3,2,3),plot(Omega,abs(W)), grid
axis([0 pi 0 1])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (linear) \rightarrow') 
subplot(3,2,5),plot(Omega,20*log10(abs(W))), grid
axis([0 pi -120 0])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (log) \rightarrow') 

w = ???;
subplot(3,2,2), stem(0:Nw-1,w), grid
axis([0 Nw-1 0 1])
title('triangular')
xlabel('n \rightarrow'), ylabel('w[n] \rightarrow') 
W = fft(???);
W = W/abs(W(1));
subplot(3,2,4),plot(Omega,abs(W)), grid
axis([0 pi 0 1])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (linear) \rightarrow') 
subplot(3,2,6),plot(Omega,20*log10(abs(W))), grid
axis([0 pi -120 0])
xlabel('\Omega \rightarrow')
ylabel('Spectrum (log) \rightarrow') 
% end
