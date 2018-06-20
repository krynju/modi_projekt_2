load('zad_1_imported_data.mat')
% plot_model=5; 
N = 40;         %max stopien 
y_model_ucz= cell(N,1);
y_model_wer= cell(N,1);
w = cell(N,1);
u=[-1:0.01:1]';
for i=1:N
    M_ucz = [ones(size(dane_stat_ucz,1),1)];
    M_wer = [ones(size(dane_stat_wer,1),1)];
    M_mod = [ones(size(u,1),1)];
    for j=1:i
        M_ucz = [M_ucz  power(dane_stat_ucz(:,1),j)];
        M_wer = [M_wer  power(dane_stat_wer(:,1),j)];
        M_mod = [M_mod  power(u,j)];
    end
    
    w{i} = M_ucz\dane_stat_ucz(:,2);
    y_model_ucz{i} = M_ucz*w{i};
    y_model_wer{i} = M_wer*w{i};
    y_model_stat{i} = M_mod*w{i};
    e_ucz(i) = sum(power(y_model_ucz{i}-dane_stat_ucz(:,2),2));
    e_wer(i) = sum(power(y_model_wer{i}-dane_stat_wer(:,2),2));
end

for plot_model=25:25
figure
subplot(2,2,[1 2])
hold on
title(join(["Charakterystyka y(u), stopien wielomianu N =",string(plot_model)]))
plot(u,y_model_stat{plot_model})
grid on
xlabel('u')
ylabel('y(u)')
hold off

% figure
subplot(2,2,3)
hold on
scatter(dane_stat_ucz(:,1),dane_stat_ucz(:,2),'.m');
plot(dane_stat_ucz(:,1),y_model_ucz{plot_model},'b')
title(join(["Dane ucz. E=",string(e_ucz(plot_model))],''))
ylabel('y(u)')
% legend("dane ucz","model")
xlabel('u')
grid on
hold off

% figure
subplot(2,2,4)
hold on
scatter(dane_stat_wer(:,1),dane_stat_wer(:,2),'.r');
plot(dane_stat_wer(:,1),y_model_wer{plot_model},'b')
title(join(["Dane wer. E=",string(e_wer(plot_model))],''))
% legend("dane wer","model")
ylabel('y(u)')
xlabel('u')
grid on

savefig(join(['zad_1_n',string(plot_model)],''));
print(join(['zad_1_n',string(plot_model)],''),'-dsvg')
hold off

end
