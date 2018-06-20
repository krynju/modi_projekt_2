load('zad_1_imported_data.mat')
M_ucz = [ones(size(dane_stat_ucz,1),1)  dane_stat_ucz(:,1)];
M_wer = [ones(size(dane_stat_wer,1),1)  dane_stat_wer(:,1)];
w = M_ucz\dane_stat_ucz(:,2);

y_model_ucz = M_ucz*w;
y_model_wer = M_wer*w;

e_ucz = sum(power(y_model_ucz-dane_stat_ucz(:,2),2));
e_wer = sum(power(y_model_wer-dane_stat_wer(:,2),2));
% 
% y_stat = w(1) + w(2)*[-1:0.01:1];
% figure
% plot([-1:0.01:1],y_stat)
% grid on
% xlabel('u')
% ylabel('y(u)')
% hold off

figure
hold on 
scatter(dane_stat_ucz(:,1),dane_stat_ucz(:,2),'.m');
plot(dane_stat_ucz(:,1),y_model_ucz,'b')
% title("model na tle danych uczacych")
legend("dane uczace","model")
grid on
xlabel('u')
ylabel('y(u)')
hold off

figure
hold on
scatter(dane_stat_wer(:,1),dane_stat_wer(:,2),'.r');
plot(dane_stat_wer(:,1),y_model_wer,'b')
% title("model na tle danych weryfikujacych")
legend("dane weryfikujace","model")
grid on
xlabel('u')
ylabel('y(u)')
hold off

