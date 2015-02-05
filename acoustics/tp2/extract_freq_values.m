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


function [freqs, values] = extract_freq_values(folder, angles, freq)
% angles : vect
% folder : string
% freq (facul.) : float

base_path = 'tp_ac_monomultipole/monomultipole_tp2/';
filename = 'FRF_RealImag.txt';

seek_freq = 0;
if (nargin>2)
	seek_freq = 1;
	path = [base_path folder '/' folder '_' num2str(angles(1)) '/' filename];
	fid = fopen(path);
	fgetl(fid);
	format = '%e %e %e';
	raw_data = fscanf(fid, format, [3 inf]);
	fclose(fid);
	raw_data = raw_data';
	f_v_filtered = (round(raw_data(:,1)) == freq);
	if (max(f_v_filtered) ~= 1)
		disp('Required frequency not found');
		return;
	end
	num_line = find(f_v_filtered);
end

format = '%e %e %e';

freqs = [];
if (seek_freq == 1)
	values = [];
else
	path = [base_path folder '/' folder '_' num2str(angles(1)) '/' filename];
	fid = fopen(path);
	fgetl(fid);
	format = '%e %e %e';
	raw_data = fscanf(fid, format, [3 inf]);
	fclose(fid);
	raw_data = raw_data';
	N = length(raw_data(:,1));
	values = zeros(N,2,length(angles));
end

for angle_id=1:length(angles)

	nb = angles(angle_id);

	path = [base_path folder '/' folder '_' num2str(nb) '/' filename];

	fid = fopen(path);
	fgetl(fid);

	if (seek_freq == 1)
		for i=2:num_line
			fgetl(fid);
		end
		raw_data = fscanf(fid, format, 3)';
		freqs = [freqs ; raw_data(1)];
		values = [values ; raw_data(2:end)];
	else
		raw_data = fscanf(fid, format, [3 inf]);
		raw_data = raw_data';
		freqs = [freqs , raw_data(:,1)];
		values(:,:,angle_id) = raw_data(:,[2,3]);
	end
	fclose(fid);

end



