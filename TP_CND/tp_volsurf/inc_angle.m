%
% inc_angle.m
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

load_plate_params;
load_wedge_params;

h = plate.thickness;

% Data

L_angle = [0 10 20];
L_tof = [32 31 30]*1e-6-2*wedge.tof

T_angle = [10 20 30 40 50];
T_tof = [34.5 33.6 33.6 33 33]*1e-6-2*wedge.tof

thetac_L = 24.7;
thetac_T = 60.6;

% compute theoretical path foreach
% theta_RL =@(angle) real(asin(sin(angle/180*pi)*plate.vL/wedge.vL));
% theta_RT =@(angle) real(asin(sin(angle/180*pi)*plate.vT/wedge.vL));
%
% l_LL = h./cos(theta_RL(L_angle));
% l_LT = h./cos(theta_RT(T_angle));

% compute speeds
% L_speed = l_LL./L_tof;
% T_speed = l_LT./T_tof;

% compute speeds
L_speed = plate.thickness./L_tof
T_speed = plate.thickness./T_tof

figure;
plot(L_angle, L_speed, 'b', 'LineWidth', 1.5);
hold on;
plot(T_angle, T_speed, 'r', 'LineWidth', 1.5);

legend('Longi', 'Transverse')
