%
% plot_disp.m
%
% Copyright (C) 2016 Mathieu Gaborit (matael) <mathieu@matael.org>
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


% célérités (mm/µs)
vL = 6.450;
vT = 3.100;

% vecteur f
f0 = 0e-3;
f1 = 5;
fpas = 10e-3;
f_v = (f0:fpas:f1);

h = 5.6; % mm

dispercurves(h, vL, vT, f_v)

%mod1
datax = [71.4 104.9 472.0 622 710]*10^-3;
datay = [40/22.4 40/24 40/15.2 40/15 40/15];
plot(datax*h, datay,'linewidth',2,'ko');
hold on
%
% %mod2
% datax2 = [71.4 104.9 472.0 622 710]*10^-3;
% datay2 = [40/184 40/128 40/56.8 40/38.4 40/40];
% plot(datax2*h, datay2,'linewidth',5,'g+');
% hold on
%
% %mod3
% datax3 = [71.4 472.0 710]*10^-3;
% datay3 = [40/326 40/116 40/50];
% plot(datax3*h, datay3,'linewidth',5,'r+');
% hold on

xlim([0 10])
ylim([0, 10])
print('-dpng', ['dispercurves_aluminium.png'])
