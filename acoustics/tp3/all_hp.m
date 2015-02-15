clear all;
close all;

mesures = {'H_refmic1_cutfreq_petitspan', 'H_refmic1_2hp_inphase', 'H_refmic1_2hp_outofphase'};
% parameters
c = 434;
R = (17.5/2)*1e-2; % internal radius

color = ['b';'r';'k'];

figure(1);
for m=1:length(mesures)
    % load FRF
    %[f, FRF, ref_PS] = extract_values('H_refmic1_cutfreq_petitspan_bb', 1);
    [f, FRF, ref_PS] = extract_values(mesures{m}, 1);
   
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
    for i=1:3
		figure(1);
        subplot(3,2,(i-1)*2+1);
        hold on;
        plot(f, (abs(A(:,i))), color(m));
        grid on;
        ylabel(['|A' num2str(i-1) '0|']);
        xlim([800 2000]);
        subplot(3,2,i*2);
        hold on;
        plot(f, unwrap(angle(A(:,i))), color(m));
        grid on;
        ylabel(['angle(A' num2str(i-1) '0)'])
        xlim([800 2000]);

		% 3-figures output
		figure(1+i);
		subplot(211)
        hold on;
        plot(f, (abs(A(:,i))), color(m));
        grid on;
        ylabel(['|A' num2str(i-1) '0|']);
        xlim([800 2000]);
		subplot(212)
        hold on;
        plot(f, unwrap(angle(A(:,i))), color(m));
        grid on;
        ylabel(['angle(A' num2str(i-1) '0)'])
		xlabel('Frequence')
        xlim([800 2000]);

    end

end

% legend figure 1
figure(1)
subplot(3,2,4);
legend('1HP', '2HP inphase', '2HP out of phase', 'location', 'northwest')
for i=0:1
	subplot(325+i)
	xlabel('Frequence')
end
print('-dpng', 'all_hp.png');

% legend figure 1
for i=2:4
	figure(i)
	subplot(211);
	title(['A', num2str(i-2) '0'])
	legend('1HP', '2HP inphase', '2HP out of phase', 'location', 'northwest')
	print('-dpng', ['all_hp_A', num2str(i-2), '0.png']);
end


