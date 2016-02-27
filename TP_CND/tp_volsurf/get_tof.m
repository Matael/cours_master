%
% get_tof.m
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

function [tof, trig_idx, echo_idx]=get_tof(filename, trig_idx, echo_idx)
	SP = 2e-8; % sampling period

	[trace, t_v, fh] = display_trace(filename,SP);
	figure(fh);


	if (nargin<3)

		% disp('Please select around the time sync pulse');
		% x = ginput(2);
		% idx = sort(floor(x));
		% [_, trig_idx] = max(trace(idx(1):idx(2)));
		% trig_idx = idx(1)+trig_idx;
		trig_idx=0;

		disp('Please select around the echo.')
		x = ginput(2);
		idx = sort(floor(x));
		[_, echo_idx] = max(trace(idx(1):idx(2)));
		echo_idx = idx(1)+echo_idx;
	end
	disp(['Trigger TimeIndex : ' num2str(trig_idx)])
	disp(['Echo TimeIndex : ' num2str(echo_idx)])

	hold on;
	plot(ones(1,2)*trig_idx, [-150 150], 'r');
	plot(ones(1,2)*echo_idx, [-150 150], 'r');

	% load_wedge_params;
  %
	% tof=abs(echo_idx-trig_idx)*SP-wedge.tof*2;
	tof=abs(echo_idx-trig_idx)*SP;
end

