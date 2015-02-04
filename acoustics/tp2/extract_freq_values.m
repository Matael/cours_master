%
% extract_freq_value.m
%
% Copyright (C) 2015 Mathieu Gaborit (matael) <mathieu@matael.org>
%
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%


function [freqs, values] = extract_freq_values(folder, angles)
% angles : vect
% folder : string

base_path = 'tp_ac_monomultipole/monomultipole_tp2/';
filename = 'FRF_RealImag.txt';

for nb=angles

	path = [base_path folder '/' folder '_' num2str(nb) '/' filename];

	fid = fopen(path);
	fgetl(fid);
	format = '%e %e %e';
	raw_data = fscanf(fid, format, [3 inf]);
	raw_data = raw_data';

	freqs = raw_data
	values = 1;
end



