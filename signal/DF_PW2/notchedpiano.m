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

[x,Fs,Nbits] = wavread('scale-piano-plus-1000Hz.wav');
Ts = 1/Fs;
%x = x(:,1);
Nx = length(x);
Nfft = 2^(fix(log2(Nx))+1);
Sxx = abs(fft(x,Nfft)).^2/Nx/Fs;
Sxx = Sxx(:,1)+Sxx(:,2)*i;

Freq = (0:Nfft/2)*Fs/Nfft;

rho = 0.95;
Fc = 1000;
theta = 2*pi*Ts*Fc;
b = [1 -2*cos(theta) 1];
a = [1 -2*rho*cos(theta) rho^2]

H1 = freqz(b,a,Nfft);
y1 = filter(b,a,x);

wavwrite(y1, Fs, Nbits, 'notched_y1.wav');


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
%plot(Freq,10*log10(Sxx1(1:Nfft/2+1)),'r', 'Linewidth',2)
grid on
xlim([Freq(1) Freq(end)]);
subplot(212)
hold off
plot(Freq,angle(Sxx(1:Nfft/2+1)),'Linewidth',2)
%plot(Freq,angle(Sxx1(1:Nfft/2+1)),'r', 'Linewidth',2)
grid on
xlim([Freq(1) Freq(end)]);
