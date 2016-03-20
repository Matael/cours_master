%
% plaque_saine.m
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

filename = 'MESSAINE_matlab.csv';
% filename = 'MES_PUBSAIN_matlab.csv';
% filename = 'MESPUB_CLOSESAIN_matlab.csv';

SF = 200e6;

toffset = 11.8e-6;

measdata = load(['newmesures2/' filename])';
timevector = fliplr((0:(size(measdata)(1)-1))/SF)+toffset;
xvector = (0:(size(measdata)(2)-1));

colormap('gray')
pcolor(xvector,timevector*1e6,measdata);
shading interp;
ylim([toffset max(timevector)]*1e6)
xlim([0 200])
axis('ydirection', 'ij')

title('')
xlabel('Distance from origin (mm)')
ylabel('TOF (us)')


print('-dpng', 'figures_out/bscan_plaque_saine.png')
