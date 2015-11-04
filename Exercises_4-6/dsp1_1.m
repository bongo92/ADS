% ADS Exercise 4
%
% Representation of Elementary Signals

clear all
close all


% ************************* Sine function and discretised sine ***********************

%This is an example of plotting continuous and discrete functions. Adapt
%the code to fullfill the exercise

t = 0:.01:15;       % time variable
xt = sin(t);        % sinus function

n  = -15:1:15;          % normalized time
Ts = pi/4;          % sampling interval
xn = sin(Ts*n);     % sinus sequence
x1 = zeros(31,1);
x1(16) = 1;
x2 = zeros(31,1);
x2(19) = 1;
x3 = zeros(31,1);
x3(13) = 1;
Omega4 = 2*pi/16;
x4 = sin(Omega4*n);
Omega5 = 2*pi/7;
x5 = cos((Omega5*n));
Omega6 = 1/2;
x6 = sin(Omega6*n);
N = 3;
N0 = 12
x8 = zeros(31,1);
x7 = sinc(pi/8*n); 
x8(N-N+16:N+N+16)=1;
x9 = zeros(37,1);
x9(-N+19:N+19)=1;
x9(-N+12+19:N+12+19)=1;
x9(-N-12+19:N-12+19)=1;



% Darstellung
figure(2), clf
subplot(3,1,1) 
hold on;
stem(n,x1)
stem(n,x2)
stem(n,x3)
grid
xlabel('n \rightarrow')
ylabel('x[n] \rightarrow')
title('Dirac');
subplot(3,1,2)
hold on;
stem(n,x4,'red')
stem(n,x5,'g')
stem(n,x6)
legend('x_4','x_5','x_6')
grid
xlabel('n \rightarrow')
ylabel('x[n] \rightarrow')
title('trigonometrisch') 
subplot(3,1,3)
hold on
stem(n,x7,'r')
stem(n,x8,'g')
n  = -18:1:18; 
stem(n,x9)
% title('special')
xlabel('n \rightarrow')
ylabel('x[n] \rightarrow')
legend('x_7','x_8','x_9')
%%

% ******************************** Rechteckfolge ********************************
M = 10;
n = -M:M;	                        % normalized time interval
x = zeros(1,2*M+1);	                % allocate memory
N = 3;	                            % (half) impulse width
x(1,M+1-N:M+1+N) = ones(1,2*N+1);	% rectangular impulse

%  Darstellung
figure(3)
stem(n,x);
grid
xlabel('n \rightarrow')
ylabel('x[n] \rightarrow')
title('rectangular impulse (N=3)')  
