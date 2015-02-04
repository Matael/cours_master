graphics_toolkit('gnuplot');

raw_data = CTTM_read_txt('balourd_seul_9khz__1deg.txt', 6);

t = raw_data(:,1);
tick = raw_data(:,2);
palier2 = raw_data(:,6);
palier1 = raw_data(:,4);
palier1 = raw_data(:,4);

subplot (311);
plot(t,tick, 'LineWidth', 2);
grid on;
ylabel("Tachymetre");

subplot (312);
plot(t,palier1, 'LineWidth', 2);
grid on;
ylabel("Palier 1");

subplot (313);
plot(t,palier2, 'LineWidth', 2);
ylabel("Palier 2");
grid on;

print "-dpng" "octave_9k_balourd_seul.png";
