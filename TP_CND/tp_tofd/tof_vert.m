%
% tof_vert.m
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


function tof=tof_vert()

	fh = input('Please enter a fh number :');
	figure(fh);

	disp('Please select 2 points on the figure with a vertical delta.')
	[x, y] = ginput(2);

	Te = 1/200e6; % Fe = 200MHz
	tof = Te*floor(abs(y(1)-y(2)));

end
