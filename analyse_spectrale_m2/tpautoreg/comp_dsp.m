figure; hold on;
plot(f,Sb,'b')
plot(f,Sy,'r');
legend('S_b','S_y')
xlabel('Frequencies')
grid on;
print('-dpng', [prefix 'comp_sb_sy.png'])

figure; hold on;
plot(f,Sb,'b')
plot(f,Sth,'r');
legend('S_b','S_{th}')
xlabel('Frequencies')
grid on;
print('-dpng', [prefix 'comp_sb_sth.png'])
