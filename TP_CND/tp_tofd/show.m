%
% show.m
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

function [measdata, fh]=show(meas)
	measdata = load(meas)';
	fh = 0;
	if size(measdata)(1)>1 && size(measdata)(2)>1
		fh = figure;
		colormap('gray')
		% pcolor(log10(abs(measdata)));
		pcolor(measdata);
		shading interp;
		% colorbar;
		title(strrep(meas, '_', '\_'))
	end
end


