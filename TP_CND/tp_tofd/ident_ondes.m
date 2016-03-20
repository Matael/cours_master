%
% ident_ondes.m
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

SF = 200e6;

offset = 87;
[ascan] = extract_ascan('newmesures2/MESSAINE_matlab.csv', offset);


timevect = (0:length(ascan)-1)/SF*1e6;
plot(timevect, ascan, 'LineWidth', 1.5);

hold on;
rectangle('position',[0.32 -42 .15 84],'EdgeColor', 'r', 'LineWidth', 2);
rectangle('position',[0.72 -180 .2 360],'EdgeColor', 'k', 'LineWidth', 2);
rectangle('position',[1.73 -180 .2 360],'EdgeColor', [62,125,0]/255, 'LineWidth', 2);

grid on;
xlabel('Temps (us)')
ylabel('Amplitude')

print('-dpng', 'figures_out/ident_ondes.png')


