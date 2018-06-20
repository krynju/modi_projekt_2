load('zad_1_imported_data.mat')
dane_stat_ucz = zeros(100,2);
dane_stat_wer = zeros(100,2);
dane_stat_sorted = sortrows(dane_stat,1);

j=1;
for i= 1:size(dane_stat_sorted,1)
    if mod(i,2) == 1 %nieparzyste
        dane_stat_ucz(j,:)=dane_stat_sorted(i,:);
    else             %parzyste
        dane_stat_wer(j,:)=dane_stat_sorted(i,:);
        j=j+1;
    end
end

figure
scatter(dane_stat_ucz(:,1),dane_stat_ucz(:,2),'m');
title("Dane statyczne uczace")
grid on
xlabel('u')
ylabel('y(u)')

figure
scatter(dane_stat_wer(:,1),dane_stat_wer(:,2),'r');
title("Dane statyczne weryfikujace")
grid on
xlabel('u')
ylabel('y(u)')