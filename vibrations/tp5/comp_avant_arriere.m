%
% comp_avant_arriere.m
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

fn_arriere = 'map_time_freq_400L_6V_moteur_arriere.mat'
fn_avant = 'map_time_freq_400L_6V_moteur_avant.mat'

arriere = load(fn_arriere);
arriere = flipud(arriere.O2');
avant = load(fn_avant);
avant = flipud(avant.O2');

f_postload= (0:8)*50;
f = (0:8)*250;

figure;
subplot(211);

imagesc(10*log10(avant));
set(gca, 'XTick', f_postload, 'XTickLabel', f, 'YTick', [0], 'YTickLabel', [0])
title("Vers l'avant");
ylabel("Temps ->")
xlabel('Frequence (Hz)')

subplot(212);

imagesc(10*log10(arriere));
set(gca, 'XTick', f_postload, 'XTickLabel', f, 'YTick', [0], 'YTickLabel', [0])
title("Vers l'arriere");
ylabel("Temps ->")
xlabel('Frequence (Hz)')

print('-dpng', 'comparaison_avant_arriere.png')
