function comp_autocorr(lags, R1, R2)
    figure;
    hold on;
    plot(lags, R1, 'b.');
    plot(lags, R2, 'r+');
    legend('R_b', 'R_y');
    xlabel('lag (samples)')
    
    center = find(lags==0);
    error_rate = abs(R1(center) - R2(center))/R1(center)*100;
    disp(['Values for null lag : ' num2str(R1(center)) ' & ' num2str(R2(center)) ' (euclidian distance : ' num2str(error_rate) '% )'])
end