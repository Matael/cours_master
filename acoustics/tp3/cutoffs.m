clear all;
close all;

c0 = 343; % sound speed
R = (17.5/2)*1e-2; % internal radius

gammas = [1.84 3.05];

cutoffs = gammas*c0/(2*pi*R);

