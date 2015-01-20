clear all;
close all;
graphics_toolkit('gnuplot');

raw_data = CTTM_read_txt("data_1k_filtre.txt", 6);

t = raw_data(:,1)*1000;
tick = raw_data(:,2);
palier2 = raw_data(:,6);
palier1 = raw_data(:,4);
palier1 = raw_data(:,4);

subplot (311);
plot(t,tick, 'LineWidth', 2);
grid on;
hold on;
first_tick = 0.035*1000;
delta = 0.041*1000;
plot([first_tick first_tick], [-.2 1], 'r', 'LineWidth', 2);
plot([first_tick+delta first_tick+delta], [-.2 1], 'r', 'LineWidth', 2);
ylim([-.2 1]);
ylabel("Tachymetre");

subplot (312);
plot(t,palier1, 'LineWidth', 2);
grid on;
ylabel("Palier 1");

subplot (313);
plot(t,palier2, 'LineWidth', 2);
ylabel("Palier 2");
xlabel("Temps (ms)")
grid on;

print "-dpng" "octave_1k_filtre.png";
