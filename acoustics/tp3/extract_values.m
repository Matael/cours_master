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


function [freqs, values, ref_ps] = extract_values(folder, ref, freq)
    % folder : string
    % freq (facul.) : float

    base_path = 'data';
    fn_FRF = 'FRF_RealImag.txt';
    fn_PS = 'PowerSpectrum.txt';

    format = '%e %e %e %e %e %e %e';


    seek_freq = 0;
    if (nargin>2)
        seek_freq = 1;
        path = [base_path '/' folder '/' filename];
        fid = fopen(path);
        fgetl(fid);
        raw_data = fscanf(fid, format, [7 inf]);
        fclose(fid);
        raw_data = raw_data';
        f_v_filtered = (round(raw_data(:,1)) == freq);
        if (max(f_v_filtered) ~= 1)
            disp('Required frequency not found');
            return;
        end
        num_line = find(f_v_filtered);
        freqs = freq
    end

    path = [base_path '/' folder '/' fn_FRF];
    fid = fopen(path);
    fgetl(fid);

    if (seek_freq == 1)
        for i=2:num_line
            fgetl(fid);
        end
        r_d = fscanf(fid, format, 7)';
        values = [r_d(2)+j*r_d(3) , r_d(4)+j*r_d(5) , r_d(6)+j*r_d(7)];
    else
        r_d = fscanf(fid, format, [7 inf]);
        r_d = r_d';
        freqs = r_d(:,1);
        values = [r_d(:,2)+j*r_d(:,3) , r_d(:,4)+j*r_d(:,5) , r_d(:,6)+j*r_d(:,7)];
    end
    fclose(fid);

    
    % reference spectrum
    format = '%e %e %e %e %e';
    path = [base_path '/' folder '/' fn_PS];
    fid = fopen(path);
    fgetl(fid);

    if (seek_freq == 1)
        for i=2:num_line
            fgetl(fid);
        end
        r_d = fscanf(fid, format, 5)';
        ref_ps = r_d(:,ref);
    else
        r_d = fscanf(fid, format, [5 inf]);
        r_d = r_d';
        ref_ps = [r_d(:,1+ref)];
    end
    fclose(fid);

end



