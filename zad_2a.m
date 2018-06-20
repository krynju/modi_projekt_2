load("zad_2_imported_data.mat");
figure
hold on
subplot(2,1,1)
plot(1:2000,dane_dyn_ucz(:,1),'Color','[1 0.45 1]');
grid on
grid minor
title("Dane dynamiczne uczace")
ylabel('u(k)')
xlabel('Próbka [k]')
subplot(2,1,2)
plot(1:2000,dane_dyn_ucz(:,2),'Color','[1 0 1]');
grid on
grid minor
ylabel('y(k)')
xlabel('Próbka [k]')

% savefig('zad_2_dynucz');
% print('zad_2_dynucz','-dsvg')

figure
hold on
subplot(2,1,1)
plot(1:2000,dane_dyn_wer(:,1),'Color','[1 0.45 0.45]');
grid on
grid minor
title("Dane dynamiczne weryfikujace")
ylabel('u(k)')
xlabel('Próbka [k]')
subplot(2,1,2)
plot(1:2000,dane_dyn_wer(:,2),'Color','[1 0 0]');
grid on
grid minor
ylabel('y(k)')
xlabel('Próbka [k]')


% savefig('zad_2_dynwer');
% print('zad_2_dynwer','-dsvg')