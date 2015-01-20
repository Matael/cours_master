%
% combo.m
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

graphics_toolkit('gnuplot');

avant_raw_data = CTTM_read_txt("data_1k_filtre.txt", 6);

avant_t = avant_raw_data(:,1)*1000;
avant_tick = avant_raw_data(:,2);
avant_palier2 = avant_raw_data(:,6);
avant_palier1 = avant_raw_data(:,4);
avant_palier1 = avant_raw_data(:,4);

apres_raw_data = CTTM_read_txt("data_equilibre.txt", 6);

apres_t = apres_raw_data(:,1)*1000;
apres_tick = apres_raw_data(:,2);
apres_palier2 = apres_raw_data(:,6);
apres_palier1 = apres_raw_data(:,4);
apres_palier1 = apres_raw_data(:,4);

subplot(211);
hold on;
grid on;

plot(avant_t, avant_palier1, 'b', 'LineWidth', 2);
plot(avant_t, avant_palier2, 'r', 'LineWidth', 2);
ylabel("Avant");

legend('Palier 1', 'Palier 2', 'location', 'southeast')
legend('boxoff');

subplot(212);
hold on;
grid on;

plot(apres_t, apres_palier1, 'b', 'LineWidth', 2);
plot(apres_t, apres_palier2, 'r', 'LineWidth', 2);
ylabel("Apres");
xlabel("Temps (ms)")


print "-dpng" "comp_equilibrage.png";


