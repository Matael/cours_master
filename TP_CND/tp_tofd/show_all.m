%
% show_all.m
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


liste = glob('mesures/*_matlab.csv')
fprintf('List of figure handles :\n')
for i=1:length(liste)
	[_, fh] = show(liste(i){1});
	if (fh>0)
		fprintf('\t%d :\tn%s\n', fh, liste(i){1});
	end
end
