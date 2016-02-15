%
% incnorm_plot.m
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

filename = 'DS0000_matlab.CSV';

trig_idx = 1193;
echo_idx = 2004;

SP = 4e-8; % sampling period

tof = (echo_idx-trig_idx)*SP;

timeserie = load(['mesures/' filename]);
timevector = SP*(0:length(timeserie)-1);


figure;
% timeserie
plot(timevector, timeserie); hold on;
axis_limit = axis();
plot([1 1]*timevector(trig_idx), axis_limit(3:4), 'r');
plot([1 1]*timevector(echo_idx), axis_limit(3:4), 'r');


grid on;
ylim([-50 50]);
title(['Incidence Normale , TOF= ' num2str(tof) 's'])


