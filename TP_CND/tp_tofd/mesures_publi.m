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
% file_2 = 'MES_PUBSAIN_matlab.csv';
file_2 = 'MESSAINE_matlab.csv';

offset = 100;

SF = 200e6;
toffset = 11.8e-6;

% file 1
figure;
measdata = load(['newmesures2/' file_1])';
timevector = fliplr((0:(size(measdata)(1)-1))/SF)+toffset;
xvector = (0:(size(measdata)(2)-1));

colormap('gray')
pcolor(xvector,timevector,measdata);
shading interp;
ylim([toffset max(timevector)])
xlim([0 200])
axis('ydirection', 'ij')
hold on;
line([offset offset], [0 max(timevector)], 'color', 'r', 'LineWidth', 2);
title('B-Scan 1')

[ascan1] = extract_ascan(['newmesures2/' file_1], offset);
figure;
ascan1_tv = (0:(length(ascan1)-1))/SF+toffset;
plot(ascan1_tv, ascan1)
title('A-Scan 1')
disp('Point the beginning of the compress. wave');
[T1, y] = ginput(1);

%file 2
figure;
measdata = load(['newmesures2/' file_2])';
timevector = fliplr((0:(size(measdata)(1)-1))/SF)+toffset;
xvector = (0:(size(measdata)(2)-1));

colormap('gray')
pcolor(xvector,timevector,measdata);
shading interp;
ylim([toffset max(timevector)])
xlim([0 200])
axis('ydirection', 'ij')
hold on;
line([offset offset], [0 max(timevector)], 'color', 'r', 'LineWidth', 2);
title('B-Scan 2')

[ascan2] = extract_ascan(['newmesures2/' file_2], offset);
figure;
ascan2_tv = (0:(length(ascan2)-1))/SF+toffset;
plot(ascan2_tv, ascan2)
title('A-Scan 2')
disp('Point the beginning of the compress. wave');
[T2, y] = ginput(1);



% Computation

L1 = 36e-3;
L2 = 72e-3;

disp(['T1 = ' num2str(T1*1e6) ' µs'])
disp(['T2 = ' num2str(T2*1e6) ' µs'])

tmp = (L2^2*T1^2 - L1^2*T2^2)/(T2^2 - T1^2);
d = 0.5*sqrt(tmp);

v = sqrt((L2^2-L1^2)/(T2^2-T1^2));

disp(['D = ' num2str(d)])
disp(['v = ' num2str(v)])

