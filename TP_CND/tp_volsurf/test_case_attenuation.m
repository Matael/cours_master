%
% test_case_attenuation.m
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

filename = 'mesures/DS0009_matlab.CSV';
SP = 2e-8;

[trace, t_v, fh] = display_trace(filename,SP);
figure(fh);


if (nargin<2)
	SP = 2e-8; % sampling period
end

number_of_peaks = input('How many peaks to include ? ');

x = ginput(number_of_peaks*2);
idx = sort(floor(x));

peaks_indexes = zeros(number_of_peaks,1);
for i=0:number_of_peaks-1
	[_, peak_idx] = max(trace(idx(2*i+1):idx(2*i+2)));
	peaks_indexes(i+1) = idx(2*i+1)+peak_idx;
end

hold on;
for i=1:length(peaks_indexes)
	plot([1 1]*peaks_indexes(i), [-1 1]*50, 'r')
end

attenuation = polyfit(peaks_indexes, log(trace(peaks_indexes)), 1)

figure;
stem(peaks_indexes, log(trace(peaks_indexes)));
hold on;
plot(peaks_indexes, attenuation(2)+attenuation(1)*peaks_indexes, 'r', 'LineWidth', 1.5);



display_trace(filename,SP);
hold on;
plot(peaks_indexes, exp(attenuation(2)*peaks_indexes), 'r', 'LineWidth', 1.5);


