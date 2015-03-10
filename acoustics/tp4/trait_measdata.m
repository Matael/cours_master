clear all;
close all;
clc; % comment out to avoid clearance

theta_vect = (0:15:180);
frequency_offset = 20; % Hz
foi_vect = [500 1700 3000]; % Frequencies of interest
foi_idx_vect = foi_vect + frequency_offset;
folder = 'meas_data';
print_folder = 'meas_figs'
prefix = 'p_';
filename = 'FRF_RealImag.txt';
format = '%e %e %e';

ratii_for_foi = zeros(length(theta_vect), 3);

for theta_idx=1:length(theta_vect)
    % cyl => cylinder
    % ff => freefield
    
    theta = theta_vect(theta_idx);
    % with cylinder
    path = [folder '/' prefix 'cyl_' num2str(theta) '/' filename]; 
    fid = fopen(path);
    fgetl(fid);
    data_cyl = fscanf(fid, format, [3 inf]);
    data_cyl = data_cyl';
    
    % without cylinder
    path = [folder '/' prefix '_' num2str(theta) '/' filename]; 
    fid = fopen(path);
    fgetl(fid);
    data_ff = fscanf(fid, format, [3 inf]);
    data_ff = data_ff';
    
    p_cyl = data_cyl(:,2)+data_cyl(:,3)*i;
    p_ff = data_ff(:,2)+data_ff(:,3)*i;
    
    ratio = p_cyl./p_ff;

    for idx=1:length(foi_idx_vect)
        ratii_for_foi(theta_idx, idx) = ratio(foi_idx_vect(idx));
    end
    
    f = data_ff(:,1);
    
    b = fir1(50, 0.04);
    ratio = filter(b,1,ratio);
    
    % figures
    figure(1); % ratio % freq
    hold off;
    plot(f, (abs(ratio)), 'b', 'LineWidth', 2);
    grid on;
    xlim([300 4000])
    title(['p_{tot} | \theta_0 = ' num2str(theta) '°'])
    print('-dpng', [print_folder '/ratii/p_' num2str(theta) '.png']);    
end

for idx=1:length(foi_vect)
    figure;
    plot(theta_vect, abs(ratii_for_foi(:,idx)));
    title(['f=' num2str(foi_vect(idx) - frequency_offset)]);
    print('-dpng', [print_folder '/alltheta_' num2str(foi_vect(idx) - frequency_offset) '.png'])
end