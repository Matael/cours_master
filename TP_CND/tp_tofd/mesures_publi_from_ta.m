%
% mesures_publi_from_ta.m
%
% Copyright (C) 2016 Mathieu Gaborit (matael) <mathieu@matael.org>
%
% Distributed under WTFPL terms
%
%            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
%                    Version 2, December 2004
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

%%%% Time convention : exp(jwt) %%%%

clear all;
close all;

T1 = 11.8e-6;
T2 = 23.5e-6;
L1 = 76e-3;
L2 = 130e-3;

tmp = (L2^2*T1^2 - L1^2*T2^2)/(T2^2 - T1^2);
d = 0.5*sqrt(tmp);

v = sqrt((L2^2-L1^2)/(T2^2-T1^2));

disp(['D = ' num2str(d)])
disp(['v = ' num2str(v)])


T1L = 11.8*10^-6;
T1T = 15.87*10^-6;
L1 = 0.076;

T2L = 23*10^-6;
T2T = 44*10^-6;
L2 = 0.130;

dL = 1/2*sqrt((L2^2*T1L^2 - L1^2*T2L^2)/(T1L^2-T2L^2))
dT = 1/2*sqrt((L2^2*T1T^2 - L1^2*T2T^2)/(T1T^2-T2T^2))

vL = sqrt((L2^2-L1^2)/(T2L^2-T1L^2))

vT = sqrt((L2^2-L1^2)/(T2T^2-T1T^2))
