% ############################### set2_3 #################################
% IIR low pass filter design with quantized coefficients 
% using two's-complement number representation in direct
% or cascade form
% Exercise 16

clear all
close all

% ############# Input of design method and lowpass tolerance scheme ##########

fprintf('set2_3 : lowpass filter design \n')
fprintf('Butterworth.......................... 1\n')
fprintf('Chebyshev I.......................... 2\n')
fprintf('Chebyshev II......................... 3\n')
fprintf('Cauer................................ 4\n')
filt = input('standard approxmation .............. (4) : ');
OmegaP = input('passband cutoff frequency........ (0.05) : ');
RP = input('passband ripple in dB............. (0.2) : ');
OmegaS = input('stopband cutoff frequency......... (0.1) : ');
RS = input('stopband attenution in dB...........(40) : ');
B = input('word length in bits................ (16) : ');

if isempty(filt)
  filt = 4;
end
if isempty(OmegaP)
  OmegaP = 0.05;
end
if isempty(RP)
  RP = 0.2;
end
if isempty(OmegaS)
  OmegaS = 0.1;
end
if isempty(RS)
  RS = 40;
end
if isempty(B)
  B = 16;
end
Dp = 1-10^(-RP/20);  % passband deviation
Ds = 10^(-RS/20);    % stopband deviation

% ################################## filt Design #################################

% filt design with zeros and poles as design result
switch filt
case 1 
  filt = 'Butterworth';
  [n,Wn] = buttord(OmegaP,OmegaS,RP,RS);  % estimation of filt order
  [z,p,kk]=butter(n,Wn);          % filt design
case 2
  filt = 'Chebyshev I';
  [n,Wn] = cheb1ord(OmegaP,OmegaS,RP,RS); % estimation of filt order
  [z,p,kk]=cheby1(n,RP,Wn);       % filt design
case 3
  filt = 'Chebyshev II';
  [n,Wn] = cheb2ord(OmegaP,OmegaS,RP,RS); % estimation of filt order
  [z,p,kk]=cheby2(n,RS,Wn);       % filt design
case 4 
  filt = 'Cauer';
  [n,Wn] = ellipord(OmegaP,OmegaS,RP,RS); % estimation of filt order
  [z,p,kk]=ellip(n,RP,RS,Wn);     % filt design
otherwise
  disp('filt type: non-valid option!')
end

% Numerator and denominator coefficients of the transfer function
[b,a] = zp2tf(z,p,kk);
% Output of the filt coefficients
fprintf('\nfilter coefficients\n')
fprintf('   k  :     b(k)     :     a(k)\n')
for k=1:length(b)
  fprintf('%4i    %12.8f   %12.8f \n',k,b(k),a(k))
end

% Frequence response
fpb = (0:.001:1.05*OmegaP)*pi;      % normalized frequency (passband)
Hpb = freqz(b,a,fpb);               % frequency response

fsb = (0.95*OmegaS:.001:.95)*pi;    % normalized frequency (stopband)
Hsb = freqz(b,a,fsb);               % frequency response

M = 1024;
[H,f] = freqz(b,a,M); H=H.'; f=f.'; % overall frequency response


% ################################## Graphics ################################

FIG1 = figure('Name','set2_2 : IIR filt design (MATLAB)',...
  'NumberTitle','off','Units','normal','Position',[.54 .40 .45 .55]);

% Zeros and poles
subplot(2,2,1), zplane(z,p), grid % pole-zero plot
xlabel('Re\{z\} \rightarrow'), ylabel('Im\{z\} \rightarrow')

% Frequency response (passband)
subplot(2,2,3), plot(fpb/pi,abs(Hpb)), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)| \rightarrow')

% Frequency response (stopband)
subplot(2,2,4), semilogy(fsb/pi,abs(Hsb)), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(j\Omega)| \rightarrow')

% Text-Output
subplot(2,2,2), axis([1 100 1 100]), axis('off')
text(5,90,['MATLAB filt design : ', filt])
text(5,70,['filt order : ',num2str(n)])
text(5,50,['passband cut off frequency : ',num2str(OmegaP)])
text(5,35,['stopband cut off frequency : ',num2str(OmegaS)])
text(5,20,['passband ripple : ',num2str(RP)])
text(5,5,['stopband attenuation : ',num2str(RS)])

disp('Weiter mit beliebiger Taste'); pause;


% ################### Quantization for direct form implementation ####################

% Quantization
LSB = 2^(-B+1);
bq = round(b/LSB)*LSB;
for k=1:3
   if bq(k)==1
      bq(k) = 1-LSB;
   end % if
end % for
aq = round(a/LSB)*LSB;
aq(1) = 1;

% Poles and zeros
[zq,pq,kq] = tf2zp(bq,aq);

% Frequence response
Hpbq = freqz(bq,aq,fpb);               % frequency response (passband)
Hsbq = freqz(bq,aq,fsb);               % frequency response (stopband)
Hdfq = (freqz(bq,aq,M)).';             % overall frequency response


% ################################## Graphics ################################

FIG2 = figure('Name','set2_2 : Quantization for direct form implementation',...
  'NumberTitle','off','Units','normal','Position',[.54 .40 .45 .55]);

% Zeros and poles
subplot(2,2,1), zplane(zq,pq), grid % pole-zero plot
xlabel('Re\{z\} \rightarrow'), ylabel('Im\{z\} \rightarrow')

% Frequency response (passband)
subplot(2,2,3), plot(fpb/pi,abs(Hpb),fpb/pi,abs(Hpbq),'-.'), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)|, |H_q(\Omega)| \rightarrow')

% Frequency response (stopband)
subplot(2,2,4), semilogy(fsb/pi,abs(Hsb),fsb/pi,abs(Hsbq),'-.'), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)|, |H_q(\Omega)| \rightarrow')

disp('Weiter mit beliebiger Taste'); pause;


% ############################ Cascade form implementation ############################

% Grouping in 2nd (or 1st) order blocks
sos = zp2sos(z,p,kk);
[L,m] = size(sos);
BAq = zeros(L,m);
Zq=[]; Pq=[]; Kq=[];
Hcpbq = ones(size(Hpb));
Hcsbq = ones(size(Hsb));
Hcq = ones(1,1024);
for m=1:L
  
  % Coefficients of the 2nd (or 1st) order blocks
  b = sos(m,1:3);       % numerator coefficients of 2nd order blocks
  a = sos(m,4:6);       % denominator coefficients of 2nd order blocks
  
  % Quantization of the coefficients of the 2nd (or 1st) order blocks
  LSB = 2^(-B+1);
  bq = round(b/LSB)*LSB;
  for k=1:3
    if bq(k)==1
      bq(k) = 1-LSB;
    end % if
  end % for
  aq = [];
  aq(1) = 1;
  aq(2) = round((a(2)/2)/LSB)*LSB;
  aq(3) = round(a(3)/LSB)*LSB; 
  for k=2:3
    if aq(k)==1
      aq(k) = 1-LSB;
    end % if
  end % for
  aq(2) = aq(2)*2;
  
  fprintf('\nfilter coefficients of block %2i\n',m)
  fprintf('   k  :     b(k)     :     a(k)     :     bq(k)     :     aq(k)\n')
  for k=1:3
    fprintf('%4i    %12.8f   %12.8f   %12.8f   %12.8f \n',...
      k,b(k),a(k),bq(k),aq(k))
    fprintf('                                   %10i *LSB %9i *LSB \n',...
      bq(k)*2^(B-1),aq(k)*2^(B-1))
  end  % for
  BAq(m,:)=[bq aq];
  
  % Zeros and poles of quantized blocks
  [zq,pq,kq] = tf2zp(bq,aq);
  Zq = [Zq; zq]; Pq = [Pq; pq]; Kq = [Kq; kq];
  
  % Frequency response of 2nd order blocks
  Hcpbq2 = freqz(bq,aq,fpb);    % actual block passband
  Hcpbq = Hcpbq.*Hcpbq2;        
  Hcsbq2 = freqz(bq,aq,fsb);    % actual block stopband
  Hcsbq = Hcsbq.*Hcsbq2;
  Hcq2 = (freqz(bq,aq,1024)).';     % actual block overall frequency band
  Hcq = Hcq.*Hcq2;
  
  % ########################################### Graphics #######################################
  
  % Representation of the 2nd (or 1st) order blocks
  if m==1
      FIG3 = figure('Name',['set2_3 : IIR filt design (cascade form : ',num2str(B),...
        ' bits )'],'NumberTitle','off','Units','normal','Position',[.54 .34 .45 .55]);
      
      % Zeros and Poles
      subplot(L,2,1), 
      zplane(zq,pq), grid
      
      % Frequency response
      [Hq,w] = freqz(bq,aq,1024);
      subplot(L,2,2), plot(w/pi,abs(Hq)), grid
      xlabel('\Omega / \pi \rightarrow')
      ylabel('|H_q(\Omega)| \rightarrow')
      hold on
      
  else
      
      % Zeros and Poles
      subplot(L,2,2*(m-1)+1)
      zplane(zq,pq), grid
      
      % Frequency response
      [Hq,w] = freqz(bq,aq,1024);
      subplot(L,2,2*(m-1)+2), plot(w/pi,abs(Hq)), grid  
      xlabel('\Omega / \pi \rightarrow')
      ylabel('|H_q(\Omega)| \rightarrow')
      
  end % if
  hold off
  
  disp('Weiter mit beliebiger Taste'); pause;
  
end  % for

% ########################################### Graphics ########################################

FIG4 = figure('Name',['set2_3 : IIR filt design (cascade form : ',num2str(B),' bits )'],...
  'NumberTitle','off','Units','normal','Position',[.54 .31 .45 .55]);

% Zeros and poles of cascade structure
subplot(2,2,1), zplane(Zq,Pq), grid

% Frequency response (before and after quantization) 
subplot(2,2,3), plot(fpb/pi,abs(Hpb), fpb/pi,abs(Hcpbq),'-.'), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)| \rightarrow')

subplot(2,2,4), semilogy(fsb/pi,abs(Hsb), fsb/pi,abs(Hcsbq),'-.'), grid
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)| \rightarrow')

% Text output
subplot(2,2,2), axis([1 100 1 100]), axis('off')
text(5,90,'cascade form')
text(5,70,['standard approximation : ',filt])
text(5,50,['filter order : ',num2str(n)])
text(5,30,['word length : ',num2str(B), ' bits'])

disp('Weiter mit beliebiger Taste'); pause;

% Comparison of cascade and direct form implementation
% Maximum frequency response deviation
MAX_dev_df = max(abs(H-Hdfq));
MAX_dev_casc = max(abs(H-Hcq));
fprintf('Maximum deviation of magnitude of frequency response(s)\n')
fprintf(' \n');
fprintf('Direct form implementation: %g \n',MAX_dev_df)
fprintf(' \n');
fprintf('Cascade implementation: %g \n',MAX_dev_casc)
fprintf(' \n');

% Tolerance scheme
% Frequency response(s) with tolerance scheme
TSu = ones(1,M); % upper limit
TSl = zeros(1,M);    % lower limit
for k=1:M
  if k <= OmegaP*M
    TSl(k) = 1-Dp;
  end
  if k >= OmegaS*M
    TSu(k) = Ds;
  end
end

% Graphics
FIG4 = figure('Name',['set2_3 : Original design (blue), direct impl. form (green), cascade form (black)'],...
  'NumberTitle','off','Units','normal','Position',[.54 .31 .45 .55]);
subplot(211)
plot(f/pi,abs(H),f/pi,abs(Hdfq),f/pi,abs(Hcq)/max(abs(Hcq)),'k',f/pi,TSu,'r',f/pi,TSl,'r'), grid
axis([0,1,0,1.3])
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)|, |H_{df,q}(\Omega)|, H_{casc,q}(\Omega)| \rightarrow')
subplot(212)
plot(f/pi,20*log10(abs(H)),f/pi,20*log10(abs(Hdfq)),f/pi,20*log10(abs(Hcq)),'k',f/pi,20*log10(TSu),'r',f/pi,20*log10(TSl),'r'), grid
axis([0,1,-RS-30,20])
xlabel('\Omega / \pi \rightarrow')
ylabel('|H(\Omega)|_{dB}, |H_{df,q}(\Omega)|_{dB}, H_{casc,q}(\Omega)|_{dB} \rightarrow')

% end
