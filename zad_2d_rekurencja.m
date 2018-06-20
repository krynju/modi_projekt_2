load('zad_2_imported_data.mat')
t_vec = [1:2000]';
plot_model=1; 
plot_stopien=1;
N = 15;         %max rzad dynamiki
max_S = 10;          %stopien
y_model_ucz= cell(N,max_S);
y_model_wer= cell(N,max_S);
w = cell(N,max_S);
e_ucz=0;
e_wer=0;
for S=1:max_S
    for i=1:N %dynamika
        if i==1
            M_test= [t_vec(1:2000-i) t_vec(1:2000-i)];
            M_ucz = [dane_dyn_ucz(1:2000-i,1) dane_dyn_ucz(1:2000-i,2)];
            M_wer = [dane_dyn_wer(1:2000-i,1) dane_dyn_wer(1:2000-i,2)];

            for j=2:S %stopien
                M_test= [M_test t_vec(1:2000-i) t_vec(1:2000-i)];
                M_ucz = [M_ucz power(dane_dyn_ucz(1:2000-i,1),j) power(dane_dyn_ucz(1:2000-i,2),j)];
                M_wer = [M_wer power(dane_dyn_wer(1:2000-i,1),j) power(dane_dyn_wer(1:2000-i,2),j)];
            end
        else
            M_test = M_test(2:size(M_test,1),:);
            M_ucz = M_ucz(2:size(M_ucz,1),:);
            M_wer = M_wer(2:size(M_wer,1),:);
            for j=1:S %stopien
                M_test = [M_test t_vec(1:size(M_ucz,1)) t_vec(1:size(M_ucz,1))];
                M_ucz = [M_ucz power(dane_dyn_ucz(1:size(M_ucz,1),1),j) power(dane_dyn_ucz(1:size(M_wer,1),2),j)];
                M_wer = [M_wer power(dane_dyn_wer(1:size(M_ucz,1),1),j) power(dane_dyn_wer(1:size(M_wer,1),2),j)];
            end
        end

        w{i,S} = M_ucz\dane_dyn_ucz(1+i:2000,2);

        M_ucz_temp=M_ucz;
        M_wer_temp=M_wer;

        y_model_ucz{i,S}=dane_dyn_ucz(1:2000,2);
        y_model_wer{i,S}=dane_dyn_wer(1:2000,2);
        for j=1:(2000-i)
            for r=1:i %rzad
                for s=1:S
                    M_ucz_temp(j,(r-1)*(2*S)+2*s) = power(y_model_ucz{i,S}(j+i -(r)),s);
                    M_wer_temp(j,(r-1)*(2*S)+2*s) = power(y_model_wer{i,S}(j+i -(r)),s);
                end
            end
            y_model_ucz{i,S}(j+i,1) = M_ucz_temp(j,:)*w{i,S};
            y_model_wer{i,S}(j+i,1) = M_wer_temp(j,:)*w{i,S};
        end
        y_model_ucz{i,S} = y_model_ucz{i,S}(1+i:2000);
        y_model_wer{i,S} = y_model_wer{i,S}(1+i:2000);
        e_ucz(i,S) = sum(power(y_model_ucz{i,S}-dane_dyn_ucz(1+i:2000,2),2));
        e_wer(i,S) = sum(power(y_model_wer{i,S}-dane_dyn_wer(1+i:2000,2),2));
    end
end
%
for plot_model=1:10
    for stopien=1:7
        f=figure;
        subplot(2,1,1)
        hold on
        plot(1:2000,dane_dyn_ucz(:,2),'Color','[1 0 1]');
        plot(1+plot_model:2000,y_model_ucz{plot_model,stopien},'-.b')
        title({join(["Model rzedu N=",string(plot_model),", stopnia S=",...
            string(stopien),", tryb z rekurencja"],''),...
            join(["\fontsize{9}Model na tle danych uczacych, E=",...
            string(e_ucz(plot_model,stopien))],'')})
        legend("dane","model",'Location','southwest')
        grid on
        grid minor
        hold off

        % figure
        subplot(2,1,2)
        hold on
        plot(1:2000,dane_dyn_wer(:,2),'Color','[1 0.45 0.45]');
        plot(1+plot_model:2000,y_model_wer{plot_model,stopien},'-.b')
        title(join(["\fontsize{9}Model na tle danych weryfikujacych, E=",string(e_wer(plot_model,stopien))],''))
        legend("dane","model",'Location','southwest')
        grid on
        grid minor
        hold off
 
        savefig(join(['zad_2d_rek_n',string(plot_model),'s',string(stopien)],''));
        print(join(['zad_2d_rek_n',string(plot_model),'s',string(stopien)],''),'-dsvg')
        close(f);
    end
end