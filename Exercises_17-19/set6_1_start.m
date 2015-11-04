% ################################ Interpolation ############################
% Exercise 17
% Investigation of different interpolation methods:
%
%   1.  Time domain lowpass interpolation using upsampling and filtering with 
%       truncated raised cosine filter
%   2.  Time domain lowpass interpolation using resample function with
%       automatic filter design
%   3.  Linear interpolation
%   4.  Frequency domain interpolation using frequency domain zero padding
%
%   HM, 18.09.2002

% ################################ Parameters ################################

fa1 = 8e3;      % Original sampling rate
T1 = 1/fa1;     % Original sampling time
f0 = 0.5e3;     % Signal frequency
I = 4;          % Interpolation factor
fa2 = I*fa1;    % Sampling rate after interpolation
T2 = T1/I;      % Sampling time after interpolation

% ############################## Signal generation ###########################

K = 40;                                 % Number of samples
t1 = 0:T1:(K-1)*T1;
x = ???;

% ########################## Interpolation method 1 ##########################
% ################### Upsampling + Raised Cosine filtering ###################

% Filling with I-1 zeros
w = [x;  zeros(I-1,length(x))];
w = w(:).';

% Design of raised cosine lowpass filter
[dummy,b1] = ???;
[H1,f] = freqz(???,???,4096,???);

% Filtering
N  = length(???)-1;  % FIR filter order
y1 = conv(???,???);
y1 = y1(N/2+1:end-N/2);


% ########################## Interpolation method 2 ##########################
% ############### Interpolation using resample function ######################

% Interpolation
[y2,b2] = ???;

% Filter frequency response
[H2,f] = freqz(???,???,4096,???);


% ########################## Interpolation method 3 ##########################
% ########################### Linear interpolation ###########################

% Design of linear interpolation filter
b3 = [zeros(1,1),triang((I-1)*2+1).', zeros(1,1)];
[H3,f] = freqz(???,???,4096,???);

% Interpolation
y3 = ???;


% ########################## Interpolation method 4 ##########################
% ################ Frequency domain interpolation (zero padding) #############

X = fft(x);
Y4 = ???;
y4 = I*real(ifft(Y4));



% ################################# Graphics #################################

% Time domain signals
figure(1), clf
stem(t1,x,'o'), grid, hold
xlabel('Time [s]')
ylabel('x')
axis([0,K*T1,-1.2,1.2]), pause

t2 = 0:T2:(I*K-1)*T2;
stem(t2,w,'kx'), 
ylabel('x, w'), pause

plot(t2,y1,'r*')
ylabel('x, w, y1'), pause

plot(t2,y2,'m*')
ylabel('x, w, y1, y2'), pause

plot(t2,y3,'c*')
ylabel('x, w, y1, y2, y3'), pause

plot(t2,y4,'g*')
ylabel('x, w, y1, y2, y3, y4'), hold, pause

% Filter impulse responses
figure(2)
clf
subplot(311)
stem(b1), grid
ylabel('Raised Cosine Filter')
subplot(312)
stem(b2), grid
ylabel('Resample Standard Filter')
subplot(313)
stem(b3), grid
ylabel('Linear Interpolation Filter')
pause

% Filter frequency responses
figure(3)
clf
plot(f,20*log10(abs(H1)),'r',f,20*log10(abs(H2)),'m',f,20*log10(abs(H3)),'c'), grid, pause

% Frequency domain graphics
figure(4)
clf
KK = 4*K;
df = 1/(KK*T1);
X = fft(x,KK);
XX = [X X X X X X X X];
f = -4*KK*df:df:(4*KK-1)*df;
plot(f,abs(XX)), grid, hold
xlabel('f [Hz]')
ylabel('|X_D(f)|'), pause
W = fft(w,I*KK);
WW = [W W];
plot(f,abs(WW),'k')
ylabel('|X_D(f)|, |W_D(f)|'), pause
Y1 = fft(y1,I*KK);
Y1Y1 = 1/I*[Y1 Y1];
plot(f,abs(Y1Y1),'r')
ylabel('|X_D(f)|, |W_D(f)|, |Y1_D(f)|'), pause
Y2 = fft(y2,I*KK);
Y2Y2 = 1/I*[Y2 Y2];
plot(f,abs(Y2Y2),'m')
ylabel('|X_D(f)|, |W_D(f)|, |Y1_D(f)|, |Y2_D(f)|'), pause
Y3 = fft(y3,I*KK);
Y3Y3 = 1/I*[Y3 Y3];
plot(f,abs(Y3Y3),'c')
ylabel('|X_D(f)|, |W_D(f)|, |Y1_D(f)|, |Y2_D(f)|, |Y3_D(f)|'), hold







