%
% attenuation.m
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

function [attenuation]=attenuation(filename, SP)

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

	attenuation = polyfit(t_v(peaks_indexes)', log(trace(peaks_indexes)), 1)
	hold on;
	plot(t_v, exp(attenuation(1).*t_v), 'r', 'LineWidth', 1.5);
end




