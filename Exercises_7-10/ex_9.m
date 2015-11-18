% Spectral analysis of periodic signals 
% Exercise 7

clear all
close all

Tx = 1e-3; 
T = 1/125;
Ts = 1e-6;
N = T/Ts;      
fs = 1/Ts;                       
df = 1/T; 

% Parameter of the signal x(t)
rect = ones(1,Tx*fs);

%signal darstellen
x = zeros(1,T*fs);
x(1:length(rect))=rect;  

f = (-N/2*df:df:(N/2-1)*df);
X = fft(x);
cx = 1/N*fftshift(X);  

figure();
plot(x);
figure();
plot(f,abs(cx));
figure();
plot(f,cx);