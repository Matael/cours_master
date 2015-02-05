%
% plot_all.m
%
% Copyright (C) 2015 Mathieu Gaborit (matael) <mathieu@matael.org>
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

folders = {
	'dipole',
	'longi69',
	'longiQaQ',
	'monopolefrf',
	'oblique',
	'trans'
};

angles = [
	5, 180;
	5, 180;
	5, 180;
	10, 360;
	5, 180;
	5, 360
];


freqs = [50 100 250 500];

for i=1:length(folders)
	folder = folders{i};
	angle = (0:angles(i,1):angles(i,2));

	disp(['=> ' folder]);
	for f=freqs
		figure(1);
		[f_v, vals] = extract_freq_values(folder, angle, f);
		cplx_frf = vals(:,1) + j*vals(:,2);
		cplx_frf = abs(cplx_frf);
		cplx_frf = 20*log10(cplx_frf/cplx_frf(1));

		angle_plot = (-180:angles(i,1):180);
		if (max(angle) ~= 360)
			cplx_frf = [flipud(cplx_frf) ; cplx_frf(2:end)]';
		else
			mid = round(length(cplx_frf)/2);
			cplx_frf = [flipud(cplx_frf(mid:end)) ; cplx_frf(2:mid)]';
		end

		dirplot(angle_plot, cplx_frf);
		print('-dpng', ['figs/' folder '_' num2str(f) '.png']);
		close(1);
	end
end




