% autocorr
plot_autocorr(b,temps,Rb,Rb_lags, 'b', prefix);
plot_autocorr(y,temps,Ry,Ry_lags, 'y', prefix)


% compare autocorrs
comp_autocorr(Rb_lags, Rb, Ry);
xlim([-1 1]*250)
print('-dpng', [prefix 'comp_autocorr.png'])

% compare dsp
comp_dsp

