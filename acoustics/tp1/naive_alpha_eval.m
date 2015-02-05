%
% naive_alpha_eval.m
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

filename = 'data/Impedance_bouche_spangrand.txt';

rho0 = 1.2041;
c0 = 343;
L = 19.5e-2;

raw_data = load(filename);
f = raw_data(:,1);
Zi = raw_data(:,2)+j*raw_data(:,3);

alpha_v  = (0:40)*1e-4;

% figure(1);
% disp('--> Entering loop')
% for idx=1:length(alpha_v)
%
% 	alpha = alpha_v(idx);
% 	k_v = (2*pi*f/c0)*(1+(1-j)*alpha);
%
%
% 	disp(['->> alpha=' num2str(alpha)]);
%
% 	Ztheo = -j*rho0*c0./tan(k_v*L);
%
% 	close(1);
% 	graphics_toolkit('gnuplot')
% 	figure(1);
% 	hold on;
% 	plot(f, log10(abs(Zi)));
% 	plot(f, log10(abs(Ztheo))-mean(log10(abs(Zi)))-2.6, 'r');
% 	grid on;
% 	title(['\alpha = ' num2str(alpha)]);
% 	xlabel('Frequence');
%
% 	print('-dpng', ['figs/alpha_' num2str(alpha) '.png'])
%
% end
% disp('--> Leaving loop')

% final fig

alpha_fin = 31e-4;
k_v = (2*pi*f/c0)*(1+(1-j)*alpha_fin);
Ztheo = -j*rho0*c0./tan(k_v*L);

graphics_toolkit('gnuplot')
figure(2);
hold on;
plot(f, log10(abs(Zi)), 'LineWidth', 2);
plot(f, log10(abs(Ztheo))-mean(log10(abs(Zi)))-2.6, 'r', 'LineWidth', 2);
legend('Mesure', 'Calcul');
grid on;
title(['\alpha = 0.0031']);
xlabel('Frequence (Hz)');
ylabel('|Z|_{dB}');

print('-dpng', 'alpha_fit.png');
