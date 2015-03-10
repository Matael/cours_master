%
% simul_exo2.m
%
% Copyright (C) 2015 Mathieu Gaborit (matael) <mathieu@matael.org>
%
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%

clear all;
close all;

Ts = 0.01;
Fs = 1/Ts;

Nfft = 1e4;
Freqd = (-Nfft/2:Nfft/2-1)*Fs/Nfft;

Hc = (1 - 2*exp(2*j*pi*Freqd*Ts) + exp(4*j*pi*Freqd*Ts))./(Ts^2* exp(2*j*pi*Freqd*Ts))

figure(1)
% subplot(211)
hold off
semilogy(Freqd,abs(Hc),'b','Linewidth',2)
title('Trapezoidal Approximation')
legend('Approximation Ts=0.01')
xlabel('Frequency (Hz)')
ylabel('Modulus')
grid on
xlim([0 50])
% subplot(212)
% hold off
% plot(Freqd,angle(Hc),'b','Linewidth',2)
% title('Trapezoidal Approximation')
% legend('Approximation Ts=0.01')
% xlabel('Frequency (Hz)')
% ylabel('Phase')
% grid on
%
