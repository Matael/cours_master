%
% compute_zray.m
%
% Copyright (C) 2015 Mathieu Gaborit (matael) <mathieu@matael.org>
%
%
% Distributed under WTFPL terms
%
%            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
%                    Version 2, December 2004
%
% Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
%
% Everyone is permitted to copy and distribute verbatim or modified
% copies of this license document, and changing it is allowed as long
% as the name is changed.
%
%            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
%   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
%
%  0. You just DO WHAT THE FUCK YOU WANT TO.
%

clear all;
close all;

%graphics_toolkit('gnuplot');

filename = 'data/Impedance_baffle_q4_try2.txt';
% filename = 'data/Impedance_sansbaffle_q4_try1.txt';



raw_data = load(filename);

L = 20e-2; % m
a = 1e-2; % rayon
rho0 = 1.2041; % kg*m-3
c0 = 343; % m*s-1

% frequency and wavenumber
f = raw_data(:,1);
w = f*2*pi;
k = w./c0;

% Reconstruction of Z_i
Re_Zi = raw_data(:,2);
Im_Zi = raw_data(:,3);

Zi = Re_Zi + j*Im_Zi;

Zray = (Zi - rho0*c0*j*tan(k*L))./(1 - j/(rho0*c0)*tan(k*L).*Zi);

Re_Zray = real(Zray);
Im_Zray = imag(Zray);

Z_ray_struve=rho0.*c0.*(1-besselj(1,2.*k.*a)./(k.*a)+j.*struve(1,2.*k.*a)'./(k.*a));
Z_ray_approx_BF=rho0.*c0.*(0.5.*(k.*a).^2+j.*w.*a./c0.*8./(3.*pi));

% figures
figure;
hold on;
plot(f, Re_Zi, 'b');
plot(f, Im_Zi, 'r');

grid on;
legend('Re\{Z_i\}', 'Im\{Z_i\}')
title('Z_i')

figure;
hold on;
semilogy(k.*a, Re_Zray, 'r');
semilogy(k.*a, Im_Zray, 'b');
semilogy(k.*a, real(Z_ray_struve),'ro',k.*a,imag(Z_ray_struve),'bo');
semilogy(k.*a, real(Z_ray_approx_BF),'r--',k.*a,imag(Z_ray_approx_BF),'b--');

grid on;
legend('Re\{Z_{ray}\}', 'Im\{Z_{ray}\}')
title('Z_{ray}')
xlabel('k a');

figure;
hold on;
loglog(k*a, abs(Zi), 'b');
loglog(k*a, abs(Zray), 'r');

grid on;
legend('|Z_{i}|', '|Z_{ray}|')
