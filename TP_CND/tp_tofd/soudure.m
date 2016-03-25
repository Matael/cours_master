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

filename = 'MESWELD_N_matlab.csv';

SF = 200e6;

% toffset = 11.8e-6;
toffset = 11.4e-6;

measdata = load(['newmesures2/' filename])';
timevector = fliplr((0:(size(measdata)(1)-1))/SF)+toffset;
xvector = (0:(size(measdata)(2)-1));

colormap('gray')
imagesc(xvector,timevector*1e6,flipud(measdata));
ylim([toffset max(timevector)]*1e6)
xlim([0 250])
axis('ij')

title('')
xlabel('Distance from origin (mm)')
ylabel('TOF (us)')

% draw circles
x = ginput(3);

hold on;
for ii=1:3;
	a = axis();
	plot([1 1]*x(ii), a(3:4), 'r', 'LineWidth', 2);
	text(x(ii)-5, 13.2, ['x=' num2str(floor(x(ii)))], 'rotation', 90, 'color', 'r', 'fontsize', 30)
end



print('-dpng', 'figures_out/soudure.png')
