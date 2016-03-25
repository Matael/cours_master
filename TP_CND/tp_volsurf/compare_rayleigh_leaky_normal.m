%
% compare_rayleigh_leaky_normal.m
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

SP = 2e-8;
leaky_fn = 'DS0009_matlab.CSV';
normal_fn = 'DS0008_matlab.CSV';

leaky_data = load(['mesures/' leaky_fn]);
normal_data = load(['mesures/' normal_fn]);

maxi = max(max(leaky_data),max(normal_data));
leaky_data = (leaky_data-mean(leaky_data))/maxi;
normal_data = (normal_data - mean(normal_data))/maxi;

time_vector = (0:length(leaky_data)-1)*SP*1e6;

figure;
plot(time_vector, leaky_data, 'r', 'LineWidth', 1.5);
hold on;
plot(time_vector, normal_data, 'b', 'LineWidth', 1.5);

xlim([50 67]);
grid on;
xlabel('Temps (us)');
ylabel('Amplitude Normalisee')
legend('Leaky Rayleigh', 'Rayleigh')




