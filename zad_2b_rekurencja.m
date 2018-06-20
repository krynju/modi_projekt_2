load('zad_2_imported_data.mat')
plot_model=2; 
N = 10;         %max stopien 
y_model_ucz = cell(N,1);
y_model_wer = cell(N,1);
w = cell(N,1);
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
 
    M_ucz_temp=M_ucz;
    M_wer_temp=M_wer;
    
    y_model_ucz{i}=dane_dyn_ucz(1:2000,2);
    y_model_wer{i}=dane_dyn_wer(1:2000,2);
    for j=1:(2000-i)
        for g=2:2:2*i
            M_ucz_temp(j,g) = y_model_ucz{i}(j + i - g/2);
            M_wer_temp(j,g) = y_model_wer{i}(j + i - g/2);
        end
        y_model_ucz{i}(j+i,1) = M_ucz_temp(j,:)*w{i};
        y_model_wer{i}(j+i,1) = M_wer_temp(j,:)*w{i};
    end
    y_model_ucz{i} = y_model_ucz{i}(1+i:2000);
    y_model_wer{i} = y_model_wer{i}(1+i:2000);
    e_ucz(i,1) = sum(power(y_model_ucz{i}-dane_dyn_ucz(1+i:2000,2),2));
    e_wer(i,1) = sum(power(y_model_wer{i}-dane_dyn_wer(1+i:2000,2),2));
end

for plot_model=1:3
figure;
subplot(2,1,1)
hold on
plot(1:2000,dane_dyn_ucz(:,2),'Color','[1 0 1]');
plot(1+plot_model:2000,y_model_ucz{plot_model},'-.b')
title({join(["Model rzedu N=",string(plot_model),", tryb z rekurencja"],''),join(["\fontsize{9}Model na tle danych uczacych, E=",string(e_ucz(plot_model))],'')})
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
savefig(join(['zad_2b_rek_n',string(plot_model)],''));
print(join(['zad_2b_rek_n',string(plot_model)],''),'-dsvg')
% close(f);
end