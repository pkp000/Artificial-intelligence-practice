clear
clc
% RP is the asymmetry matrix
%%训练数据
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\数据（45CSM+45HC）\CSM'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
%%训练数据
for k=3:22
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径
    dirOutput = dir(fullfile(subdirpath,'*CSM.xlsx'));
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    data=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
    i=1;
    for m=0:2
        for n=(2+15*m):(4+15*m)
            src = data(:,n);
            src = src( ~ isnan(src));
            [max_1,min_1,peak,p2p,mean_1,averageAmplitude,rootAmplitude,var_1,std_1,rms] = timeDomainFeatures(src);
            p2p1(k-2,i) = p2p;
            mean1(k-2,i) = mean_1;
            rootAmplitude1(k-2,i) = rootAmplitude;
            std1(k-2,i) = std_1;
            i=i+1;
        end
    end
    disp(k-2)
end
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\数据（45CSM+45HC）\HC'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
for k=3:17
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径
    dirOutput = dir(fullfile(subdirpath,'*HC.xlsx'));
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    data=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
    i=1;
    for m=0:2
        for n=(2+15*m):(4+15*m)
            src = data(:,n);
            src = src( ~ isnan(src));
            [max_1,min_1,peak,p2p,mean_1,averageAmplitude,rootAmplitude,var_1,std_1,rms] = timeDomainFeatures(src);
            p2p2(k-2,i) = p2p;
            mean2(k-2,i) = mean_1;
            rootAmplitude2(k-2,i) = rootAmplitude;
            std2(k-2,i) = std_1;
            i=i+1;
        end
    end
    disp(k-2)
end
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\时频域+小波.xlsx',p2p1,'p2p','C2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\时频域+小波.xlsx',p2p2,'p2p','C22');
% 
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\时频域+小波.xlsx',mean1,'mean','C2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\时频域+小波.xlsx',mean2,'mean','C22');
% 
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\时频域+小波.xlsx',rootAmplitude1,'rootAmplitude','C2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\时频域+小波.xlsx',rootAmplitude2,'rootAmplitude','C22');
% 
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\时频域+小波.xlsx',std1,'std','C2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\时频域+小波.xlsx',std2,'std','C22');