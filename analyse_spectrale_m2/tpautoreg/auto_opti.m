clear all;
close all;
clc;

Nmax=50;

% bruit_structure loading :
% fe : sampling frequency
% b : data vector
% temps : time vector
load bruit_structure
prefix = 'auto_';

% == Autocorrelation computation ==
[Rb, Rb_lags] = xcorr(b, 'biased');
Rb_center = find(Rb_lags==0);
lenb = length(b);

% == AR modelling ==
AIC = zeros(1,Nmax);
FPE = zeros(1,Nmax);

for model_order=1:Nmax
    lev_a = levinson(Rb(Rb_center:Rb_center+model_order));
    V = lev_a*Rb(Rb_center:Rb_center+model_order);
    FPE(model_order) = V*(lenb+model_order+1)/(lenb-model_order-1);
    AIC(model_order) = log(V)+2*model_order/lenb;
end

% plot both criterion
plot(1:Nmax, AIC, 'b+-');
hold on;
plot(1:Nmax, FPE, 'r+-');
legend('AIC', 'FPE');
xlabel('Model Order')

% choose order (GUI inside)
disp('Choose model order');
[x,y] = ginput(1);

model_order = floor(x);
disp(['Chosen model order : ' num2str(model_order)])

% Compute AR model coeffs
[lev_a, error] = levinson(Rb(Rb_center:Rb_center+model_order));
V = lev_a*Rb(Rb_center:Rb_center+model_order);
wn = sqrt(V)*randn(1,length(temps));
y = filter([1], lev_a, wn);
disp(['Prediction error on lev_a : ' num2str(error)])

[Ry, Ry_lags] = xcorr(y, 'biased');

% == DSP ==
nfft = 64;
[Sb,f] = pwelch(b,hanning(nfft), nfft/2, nfft, fe);
[Sy,f] = pwelch(y,hanning(nfft), nfft/2, nfft, fe);
[Sth,f] = theo_psd(lev_a,V,fe,f);

display_stuff;

