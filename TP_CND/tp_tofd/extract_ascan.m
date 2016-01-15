%
% extract_ascan.m
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

function [ascan, offset] = extract_ascan(measfile,offset)
	% ascan extracted a-scan
	% measfile file containing ndt data (as a matrix)

	measdata = load(measfile)';

	if nargin<2
		figure(20000);
		pcolor(measdata);
		shading interp;
		title([strrep(measfile, '_', '\_') ' : Select A-Scan'])

		disp('Please select A-scan.');
		[x, _] = ginput(1);
		close(20000);
		offset = floor(x)
	end


	ascan = measdata(:,offset);

end
