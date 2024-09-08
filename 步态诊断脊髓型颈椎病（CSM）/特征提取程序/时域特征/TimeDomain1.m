clear
clc
% RP is the asymmetry matrix
%%ѵ������
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\���ݣ�45CSM+45HC��\CSM'; %��ȡ���ļ���
subdir  = dir( maindir );%��ȡ���ļ���
%%ѵ������
for k=3:22
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%�������ļ����ڲ�·��
    dirOutput = dir(fullfile(subdirpath,'*CSM.xlsx'));
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    data=xlsread([subdirpath,'\',filename],1);  %%�ӵ�һ�ű������ȡ����
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
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\���ݣ�45CSM+45HC��\HC'; %��ȡ���ļ���
subdir  = dir( maindir );%��ȡ���ļ���
for k=3:17
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%�������ļ����ڲ�·��
    dirOutput = dir(fullfile(subdirpath,'*HC.xlsx'));
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    data=xlsread([subdirpath,'\',filename],1);  %%�ӵ�һ�ű������ȡ����
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
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\ʱƵ��+С��.xlsx',p2p1,'p2p','C2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\ʱƵ��+С��.xlsx',p2p2,'p2p','C22');
% 
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\ʱƵ��+С��.xlsx',mean1,'mean','C2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\ʱƵ��+С��.xlsx',mean2,'mean','C22');
% 
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\ʱƵ��+С��.xlsx',rootAmplitude1,'rootAmplitude','C2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\ʱƵ��+С��.xlsx',rootAmplitude2,'rootAmplitude','C22');
% 
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\ʱƵ��+С��.xlsx',std1,'std','C2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\ʱƵ��+С��.xlsx',std2,'std','C22');