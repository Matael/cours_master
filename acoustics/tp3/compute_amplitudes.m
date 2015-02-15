clear all;
close all;

% parameters
c = 434;
R = (17.5/2)*1e-2; % internal radius

% load FRF
%[f, FRF, ref_PS] = extract_values('H_refmic1_cutfreq_petitspan_bb', 1);
[f, FRF, ref_PS] = extract_values('H_refmic1_cutfreq', 1);

H12 = FRF(:,1);
H13 = FRF(:,2);
H14 = FRF(:,3);

abs_P1 = sqrt(ref_PS);

% first zeros of first order derivatives of bessels (/R)
k00 = 0;
k10 = 1.84/R;
k20 = 3.05/R;

A = zeros(length(H12), 3);
A(:,1) = abs_P1.*(ones(length(H12),1)+H12+H13+H14)/(4*besselj(0,k00*R));
A(:,2) = abs_P1.*(ones(length(H12),1)-H13)/(2*besselj(1,k10*R));
A(:,3) = abs_P1.*(ones(length(H12),1)-H12+H13-H14)/(4*besselj(2,k20*R));

% plot unwrapped_phases
figure;
for i=1:3
    subplot(3,2,(i-1)*2+1);
    plot(f, 20*log10(abs(A(:,i))));
    grid on;
    ylabel(['|A_{' num2str(i-1) '0}|']);
    subplot(3,2,i*2);
    plot(f, unwrap(angle(A(:,i))));
    grid on;
    ylabel(['\Theta(A_{' num2str(i-1) '0})'])
end

figure;
color = ['b';'r';'k'];
for i=1:3
    subplot(2,1,1)
    plot(f, 20*log10(abs(A(:,i))), color(i));
    hold on;
    grid on;
    ylabel(['|A_{ij}|']);
    subplot(2,1,2);
    plot(f, unwrap(angle(A(:,i))), color(i));
    hold on;
    grid on;
    ylabel(['\Theta(A_{ij})'])
end
subplot(211);
legend('A_{00}', 'A_{10}', 'A_{20}')