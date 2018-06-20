load('zad_2_imported_data.mat')
plot_model=1; 
N = 15;         %max rzad dynamiki
max_S = 10;          %stopien
y_model_ucz= cell(N,max_S);
y_model_wer= cell(N,max_S);
w = cell(N,max_S);
e_ucz=0;
e_wer=0;
w_count=zeros(N,max_S);
for S=1:max_S
    
    for i=1:N %dynamika
        if i==1
            M_ucz = [dane_dyn_ucz(1:2000-i,1) dane_dyn_ucz(1:2000-i,2)];
            M_wer = [dane_dyn_wer(1:2000-i,1) dane_dyn_wer(1:2000-i,2)];

            for j=2:S %stopien
                M_ucz = [M_ucz power(dane_dyn_ucz(1:2000-i,1),j) power(dane_dyn_ucz(1:2000-i,2),j)];
                M_wer = [M_wer power(dane_dyn_wer(1:2000-i,1),j) power(dane_dyn_wer(1:2000-i,2),j)];
            end
        else
            M_ucz = M_ucz(2:size(M_ucz,1),:);
            M_wer = M_wer(2:size(M_wer,1),:);
            for j=1:S %stopien
                M_ucz = [M_ucz power(dane_dyn_ucz(1:size(M_ucz,1),1),j) power(dane_dyn_ucz(1:size(M_wer,1),2),j)];
                M_wer = [M_wer power(dane_dyn_wer(1:size(M_ucz,1),1),j) power(dane_dyn_wer(1:size(M_wer,1),2),j)];
            end
        end

        w{i,S} = M_ucz\dane_dyn_ucz(1+i:2000,2);
        w_count(i,S)= size(w{i,S},1);
        y_model_ucz{i,S} = M_ucz*w{i,S};
        y_model_wer{i,S} = M_wer*w{i,S};
        e_ucz(i,S) = sum(power(y_model_ucz{i,S}-dane_dyn_ucz(1+i:2000,2),2));
        e_wer(i,S) = sum(power(y_model_wer{i,S}-dane_dyn_wer(1+i:2000,2),2));
        
    end

end
for plot_model=1:15
    for stopien=1:10
        f=figure;
        subplot(2,1,1)
        hold on
        plot(1:2000,dane_dyn_ucz(:,2),'Color','[1 0 1]');
        plot(1+plot_model:2000,y_model_ucz{plot_model,stopien},'-.b')
        title({join(["Model rzedu N=",string(plot_model),", stopnia S=",...
            string(stopien),", tryb bez rekurencji"],''),...
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
 
        savefig(join(['zad_2d_bez_n',string(plot_model),'s',string(stopien)],''));
        print(join(['zad_2d_bez_n',string(plot_model),'s',string(stopien)],''),'-dsvg')
        close(f);
    end
end