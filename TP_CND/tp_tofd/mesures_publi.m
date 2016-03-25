%
% mesures_publi.m
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

clear all;
close all;


file_1 = 'MESPUB_CLOSESAIN_matlab.csv';
file_2 = 'MES_PUBSAIN_matlab.csv';
file_2 = 'MESSAINE_matlab.csv';

L1 = 36e-3;
L2 = 72e-3;

prefix = 'newmesures2/'

offset = 100;

SF = 200e6;
toffset1 = 11.8e-6;
toffset2 = toffset1*L2/L1;

% file 1
figure;
measdata = load([prefix file_1])';
timevector = fliplr((0:(size(measdata)(1)-1))/SF)+toffset1;
xvector = (0:(size(measdata)(2)-1));

colormap('gray')
imagesc(xvector,timevector,measdata);
% shading interp;
ylim([toffset1 max(timevector)])
xlim([0 200])
axis('ij')
hold on;
line([offset offset], [0 max(timevector)], 'color', 'r', 'LineWidth', 2);
title('B-Scan 1')

[ascan1] = extract_ascan([prefix file_1], offset);
figure;
ascan1_tv = (0:(length(ascan1)-1))/SF+toffset1;
plot(ascan1_tv, ascan1)
title('A-Scan 1')
disp('Point the beginning of the compress. wave');
[T1, y] = ginput(1);

%file 2
figure;
measdata = load([prefix file_2])';
timevector = fliplr((0:(size(measdata)(1)-1))/SF)+toffset2;
xvector = (0:(size(measdata)(2)-1));

colormap('gray')
imagesc(xvector,timevector,measdata);
% shading interp;
ylim([toffset2 max(timevector)])
xlim([0 200])
axis('ij')
hold on;
line([offset offset], [0 max(timevector)], 'color', 'r', 'LineWidth', 2);
title('B-Scan 2')

[ascan2] = extract_ascan([prefix file_2], offset);
figure;
ascan2_tv = (0:(length(ascan2)-1))/SF+toffset2;
plot(ascan2_tv, ascan2)
title('A-Scan 2')
disp('Point the beginning of the compress. wave');
[T2, y] = ginput(1);


% figure with both ascans
figure;
subplot(211);
plot(ascan1_tv*1e6, ascan1, 'LineWidth', 2); hold on;
plot([1 1]*T1*1e6, [-1 1]*200, 'r', 'LineWidth', 2);
ylim([-1 1]*200);
set(gca, 'yTick', []);
grid on;
ylabel(['Spacing : ' num2str(L1*1e3) 'mm']);
subplot(212);
plot(ascan2_tv*1e6, ascan2, 'LineWidth', 2); hold on;
plot([1 1]*T2*1e6, [-1 1]*200, 'r', 'LineWidth', 2);
ylim([-1 1]*200);
set(gca, 'yTick', []);
grid on;
ylabel(['Spacing : ' num2str(L2*1e3) 'mm']);
xlabel('Time (\mu s)')
print('-dpng', '-tight', 'figures_out/time_records_publi.png')


% Computation

disp(['T1 = ' num2str(T1*1e6) ' µs'])
disp(['L1 = ' num2str(L1*1e3) ' mm'])
disp(['T2 = ' num2str(T2*1e6) ' µs'])
disp(['L2 = ' num2str(L2*1e3) ' mm'])

tmp = (L2^2*T1^2 - L1^2*T2^2)/(T2^2 - T1^2);
d = 0.5*sqrt(tmp)*10;

v = sqrt((L2^2-L1^2)/(T2^2-T1^2));

disp(['D = ' num2str(d)])
disp(['v = ' num2str(v)])

printf('\n\n\n')

printf('%d & %2.2f\\\\\n', L1*1e3, T1*1e6)
printf('%d & %2.2f\\\\\n', L2*1e3, T2*1e6)

printf('\n\n\n')

% Comparison with theoretical value

v_theo = 3200;
d_theo = 20e-3;

err_d = (d_theo-d)/d_theo*100;
err_v = (v_theo-v)/v_theo*100;

printf('error on d : %2.2f%%\n', err_d)
printf('error on v : %2.2f%%\n', err_v)

