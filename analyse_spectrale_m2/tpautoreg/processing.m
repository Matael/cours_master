clear all;
close all;
clc;

% bruit_structure loading :
% fe : sampling frequency
% b : data vector
% temps : time vector
load bruit_structure

prefix = 'fixed_';
% == Autocorrelation computation ==
[Rb, Rb_lags] = xcorr(b, 'biased');
Rb_center = find(Rb_lags==0);

% == AR modelling ==
model_order = 10;
[lev_a, error] = levinson(Rb(Rb_center:Rb_center+model_order));
V = lev_a*Rb(Rb_center:Rb_center+model_order);
wn = sqrt(V)*randn(1,length(temps));
y = filter([1], lev_a, wn);
disp(['Prediction error on lev_a : ' num2str(error)])

[Ry, Ry_lags] = xcorr(y, 'biased');

% == DSP ==
nfft = 64;
[Sb,f] = pwelch(b,hanning(nfft), nfft/2, nfft, fe); Sb = Sb/2;
[Sy,f] = pwelch(y,hanning(nfft), nfft/2, nfft, fe); Sy = Sy/2;
[Sth,f] = theo_psd(lev_a,V,fe,f);

display_stuff;

