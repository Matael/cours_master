clear all
close all
% clc

VL = 5900;
VT = 3200;

T1L = 11.95*10^-6;
T1T = 15.87*10^-6;
L1 = 0.076;

T2L = 23.5*10^-6;
T2T = 44*10^-6;
L2 = 0.130;

dL = 1/2*sqrt((L2^2*T1L^2 - L1^2*T2L^2)/(T1L^2-T2L^2))
dT = 1/2*sqrt((L2^2*T1T^2 - L1^2*T2T^2)/(T1T^2-T2T^2))

vL = sqrt((L2^2-L1^2)/(T2L^2-T1L^2))

vT = sqrt((L2^2-L1^2)/(T2T^2-T1T^2))
