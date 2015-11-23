function plot_autocorr(sig,times,Rsig,Rsiglags,signame,prefix)
    figure;
    subplot(211)
    plot(times, sig);
    xlabel('time')
    ylabel(signame)
    xlim([0 max(times)]);
    grid on;
    
    subplot(212);
    plot(Rsiglags, Rsig);
    xlabel('lag (samples)')
    ylabel(['R_' signame])
    xlim([-250 250]);
    ylim([-20 25])
    grid on;
    
    print('-dpng', [prefix 'signal_' signame '.png'])
end