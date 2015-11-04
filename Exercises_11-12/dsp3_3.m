% Short term spectral analysis

% Load audio signal
fprintf('dsplab7_1 : June 2001 : spectral analysis\n')
filename = input('name of audio file (*.wav): ','s');
%[y,fs,bits] = wavread(filename);
[y,fs] = audioread(filename);
M = input('FFT-length: ');
OL = input('Overlap of the fft blocks: ');

% Signal parameters
Ts = 1/fs;		% Sampling time
N = length(y);	% Number of signal samples
T = N*Ts;	    % Duration of the signal
df = 1/T;  		% Spectral resolution

% Spectral analysis: total signal
Y = fft(y);

% Graphics
t=0:Ts:(length(y)-1)*Ts; 	% Time scale
FIG1=figure('Name','Übung 3 - Beispiel 4','NumberTitle','off');
subplot(2,1,1),plot(t,y), grid
xlabel('t [s]  \rightarrow')
ylabel('y(t)  \rightarrow')
f=0:df:(N-1)*df; 				% Frequency scale
YY = abs(Y)/max(abs(Y));	% Abs, Scaling
subplot(2,1,2), plot(f,YY), grid
axis([0 fs/2 0 1]);
xlabel('f [Hz]   \rightarrow'), ylabel('norm. |Y(f)| \rightarrow')
soundsc(y,fs,bits);   		% Sound

% Spectral analysis - short term
%M = 4096;            			% fft length
w = hamming(M);     			% Hamming window
%OL = 2;             			% Overlap of the fft blocks, i.e, size of overlap M/OL  
N = floor(length(y)/M);
Y = zeros(OL*N,M/2);
for k=1:OL*(N-1)
  start = 1+(M/OL)*(k-1);
  stop  = start+M-1;
  YY    = fft(w.*y(start:stop))';
  Y(k,:)= abs(YY(1:M/2));	% 0...8kHz
end

% Graphics
figure(3), clf
Y = abs(Y(:,1:M/4));			% 0...4kHz
Ymax=max(max(Y));
Y = Y/Ymax;
dt = M/OL*Ts; t = 0:dt:(OL*N-1)*dt;		% Time scale
df = fs/M; f=0:df:(M/4-1)*df; 		   	% Frequency scale
h = waterfall(f,t,Y);
view(30,30)
xlabel(' f [Hz] \rightarrow'), ylabel(' t [s] \rightarrow')
zlabel('magnitudes of short term dft spectra \rightarrow')
% end