%
% vector_get.m
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

function [idx]=vector_get(vect, approx)
	idx=[];
	dv = max(vect)/length(vect);
	size(approx)
	for i=approx
		thieve = (vect <= i+0.5*dv)&(vect >= i-0.5*dv);
		% [_,idm] = find(thieve)
		idx = [idx find(thieve)];
	end
end


