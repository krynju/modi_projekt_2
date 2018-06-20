load('zad_2_imported_data.mat')
plot_model=1; 
N = 30;         %max rzad 
y_model_ucz= cell(N,1);
y_model_wer= cell(N,1);
w = cell(N,1);
w_count = zeros(N,1);
for i=1:N
    if i==1
        M_ucz = [dane_dyn_ucz(1:2000-i,1) dane_dyn_ucz(1:2000-i,2)];
        M_wer = [dane_dyn_wer(1:2000-i,1) dane_dyn_wer(1:2000-i,2)];
    else
        M_ucz = M_ucz(2:size(M_ucz,1),:);
        M_wer = M_wer(2:size(M_wer,1),:);
        M_ucz = [M_ucz dane_dyn_ucz(1:size(M_ucz,1),1) dane_dyn_ucz(1:size(M_wer,1),2)];
        M_wer = [M_wer dane_dyn_wer(1:size(M_ucz,1),1) dane_dyn_wer(1:size(M_wer,1),2)];
    end
    
    w{i} = M_ucz\dane_dyn_ucz(1+i:2000,2);
    w_count(i) = size(w{i},1);
    y_model_ucz{i} = M_ucz*w{i};
    y_model_wer{i} = M_wer*w{i};
    e_ucz(i,1) = sum(power(y_model_ucz{i}-dane_dyn_ucz(1+i:2000,2),2));
    e_wer(i,1) = sum(power(y_model_wer{i}-dane_dyn_wer(1+i:2000,2),2));
end
for plot_model=1:3
figure
subplot(2,1,1)
hold on
plot(1:2000,dane_dyn_ucz(:,2),'Color','[1 0 1]');
plot(1+plot_model:2000,y_model_ucz{plot_model},'-.b')
title({join(["Model rzedu N=",string(plot_model),", tryb bez rekurencji"],''),join(["\fontsize{9}Model na tle danych uczacych, E=",string(e_ucz(plot_model))],'')})
legend("dane","model",'Location','southwest')
grid on
grid minor
hold off

% figure
subplot(2,1,2)
hold on
plot(1:2000,dane_dyn_wer(:,2),'Color','[1 0.45 0.45]');
plot(1+plot_model:2000,y_model_wer{plot_model},'-.b')
title(join(["\fontsize{9}Model na tle danych weryfikujacych, E=",string(e_wer(plot_model))],''))
legend("dane","model",'Location','southwest')
grid on
grid minor
hold off
join(["Dane ucz. E=",string(e_ucz(plot_model))],'')
savefig(join(['zad_2b_bez_n',string(plot_model)],''));
print(join(['zad_2b_bez_n',string(plot_model)],''),'-dsvg')
end