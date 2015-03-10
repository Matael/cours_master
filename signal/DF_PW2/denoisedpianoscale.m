%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Piano scale : filtering with
% different LP filters
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% L. Simon December 2014
%

clear;close all;clc

[x,Fs,Nbits] = wavread('noisy-scale-piano.wav');

%x = x(:,1);
Nx = length(x);
Nfft = 2^(fix(log2(Nx))+1);
Sxx = abs(fft(x,Nfft)).^2/Nx/Fs;
Sxx = Sxx(:,1)+Sxx(:,2)*i;

Freq = (0:Nfft/2)*Fs/Nfft;


%%%%%%%% Premier filtre : simple lowpass Nh=6 %%%%%%%%%

Nh1 = 6;
b1 = ones(Nh1,1)/Nh1;
H1 = freqz(b1,1,Nfft,'whole');
y1 = filter(b1,1,x);
Sxx1 =  abs(H1).^2.*Sxx;

%%%%%%%% Premier filtre : simple lowpass Nh=20 %%%%%%%%%

Nh2 = 20;
b2 = ones(Nh2,1)/Nh2;
H2 = freqz(b2,1,Nfft,'whole');
y2 = filter(b2,1,x);
Sxx2 =  abs(H2).^2.*Sxx;

%%%%%%%% Fir PM %%%%%%%%%%%%%%%%%%%

% honteusement pompé depuis le PDF
rp = 0.05; % Passband ripple
rs = 40; % Stopband ripple
f = [1.2e3 1.5e3]; % Cutoff frequencies
a = [1 0]; % Desired amplitudes
% Compute deviations
dev = [(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)];
% matlab
[npm,fo,ao,w] = firpmord(f,a,dev,Fs);
%h3 = firpm(npm,fo,ao,w);
h3 = remez(npm,fo,ao,w);

H3 = freqz(h3, 1, Nfft);
y3 = filter(h3,1,x); % the filtering (see helpbasincfunctions.m)
Sxx3 = abs(H3).^2.*Sxx;

figure
subplot(211)
hold off
plot(Freq,10*log10(real(Sxx(1:Nfft/2+1))),'Linewidth',2)
grid on
xlim([Freq(1) Freq(end)]);
subplot(212)
hold off
plot(Freq,10*log10(imag(Sxx(1:Nfft/2+1))),'Linewidth',2)
grid on
xlim([Freq(1) Freq(end)]);

figure
subplot(211)
hold off
plot(Freq,10*log10(Sxx(1:Nfft/2+1)),'Linewidth',2)
hold on;
plot(Freq,10*log10(Sxx1(1:Nfft/2+1)),'g', 'Linewidth',2)
plot(Freq,10*log10(Sxx2(1:Nfft/2+1)),'r', 'Linewidth',2)
plot(Freq,10*log10(Sxx3(1:Nfft/2+1)),'k', 'Linewidth',2)
grid on
xlim([Freq(1) Freq(end)]);
subplot(212)
hold off
plot(Freq,angle(Sxx(1:Nfft/2+1)),'Linewidth',2)
plot(Freq,angle(Sxx1(1:Nfft/2+1)),'g', 'Linewidth',2)
plot(Freq,angle(Sxx2(1:Nfft/2+1)),'r', 'Linewidth',2)
plot(Freq,angle(Sxx3(1:Nfft/2+1)),'k', 'Linewidth',2)
grid on
xlim([Freq(1) Freq(end)]);

wavwrite(y1, Fs, Nbits, 'denoised_y1.wav');
wavwrite(y2, Fs, Nbits, 'denoised_y2.wav');
wavwrite(y3, Fs, Nbits, 'denoised_y3.wav');
