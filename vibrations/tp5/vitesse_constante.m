%
% comp_avant_moteur.m
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

graphics_toolkit('gnuplot')

fn_moteur = 'map_time_freq_400L_6V_moteur_arriere.mat'
fn_point2 = 'map_time_freq_400L_6V.mat'
fn_point1 = 'map_time_freq_400L_6V_point1.mat'


moteur = load(fn_moteur);
moteur = flipud(moteur.O2');
point2 = load(fn_point2);
point2 = flipud(point2.O2');
point1 = load(fn_point1);
point1 = flipud(point1.O2');

f_postload= (0:8)*50;
f = (0:8)*250;

figure;
subplot(311);

imagesc(10*log10(moteur));
set(gca, 'XTick', f_postload, 'XTickLabel', f, 'YTick', [0], 'YTickLabel', [0])
title("Moteur");
ylabel("Temps ->")
xlabel('Frequence (Hz)')

subplot(312);

imagesc(10*log10(moteur));
set(gca, 'XTick', f_postload, 'XTickLabel', f, 'YTick', [0], 'YTickLabel', [0])
title("Point 1");
ylabel("Temps ->")
xlabel('Frequence (Hz)')

subplot(313);

imagesc(10*log10(point2));
set(gca, 'XTick', f_postload, 'XTickLabel', f, 'YTick', [0], 'YTickLabel', [0])
title("Point 2");
ylabel("Temps ->")
xlabel('Frequence (Hz)')


print('-dpng', 'vitesse_constante.png')
