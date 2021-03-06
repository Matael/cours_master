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

load_wedge_params;
load_plate_params;

filename = 'DS0000_matlab.CSV';

trig_idx = 1193;
echo_idx = 1991;

SP = 4e-8; % sampling period

tof = ((echo_idx-trig_idx)*SP-2*wedge.tof)/2;

timeserie = load(['mesures/' filename]);
timevector = SP*(0:length(timeserie)-1)*1e6;


figure;
% timeserie
plot([1 1]*timevector(trig_idx), [-1 1]*1.2, 'r', 'LineWidth', 1.5); hold on;
plot([1 1]*timevector(echo_idx), [-1 1]*1.2, 'r', 'LineWidth', 1.5);
plot(timevector, timeserie/max(timeserie), 'LineWidth', 1.1);

xlim([4.0645e-05   1.4571e-04]*1e6);
ylim([-1.2 1.2]);

grid on;
title(['Incidence Normale , TOF= ' num2str(tof) 's'])
ylabel('Amplitude Normalisee')
xlabel('Temps (us)')


print('-dpng', 'figures_out/DS0000_incnorm.png');

% Error computation
measured_speed= plate.thickness/tof;
relative_err = abs(measured_speed-plate.vL)/plate.vL*100;

disp(['Measured plate comp. wave speed : ' num2str(measured_speed) 'm']);
disp(['Error on plate thickness : ' num2str(relative_err) '%']);

