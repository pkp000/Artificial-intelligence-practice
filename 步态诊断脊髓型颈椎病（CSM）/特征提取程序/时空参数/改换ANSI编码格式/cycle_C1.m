clear
clc
%%%%%%%%��ȡ���ļ��У���ʵ����Ϊ�������������ݵġ�CSM���͡�HC���ļ��У�����ʵ������޸ģ�����ʱ�ղ�����ȡ�����Լ�ʱ��������ȡ����ͬ��
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\���ݣ�45CSM+45HC��\CSM'; 
subdir  = dir( maindir );%��ȡ���ļ���
%%��������ǰ��
i=1;
for k=3:22
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%�������ļ����ڲ�·���������Լ����ļ�·������
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%�����Լ����ļ�����׺����
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%�ӵ�һ�ű������ȡ����
    data1 = num(:,4);
    data1 = data1( ~ isnan(data1));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    cycle_mean(1,:) = ((location1(length(location1),1)-location1(1,1))/200)/(length(location1)-1);
    cycle_mean1(i,:) = cycle_mean(1,:);
    i=i+1;
    disp(k-2)
end
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\���ݣ�45CSM+45HC��\HC'; %��ȡ���ļ��У�����ʵ������޸ģ�
subdir  = dir( maindir );%��ȡ���ļ���
i=1;
for k=3:17
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%�������ļ����ڲ�·���������Լ����ļ�·������
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%�����Լ����ļ�����׺����
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%�ӵ�һ�ű������ȡ����
    data1 = num(:,4);
    data1 = data1( ~ isnan(data1));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    cycle_mean(1,:) = ((location1(length(location1),1)-location1(1,1))/200)/(length(location1)-1);
    cycle_mean2(i,:) = cycle_mean(1,:);
    i=i+1;
    disp(k-2)
end
%%%%%������д����ʾ��������ṩ,����ʱ�ղ�����ȡ�����Լ�ʱ��������ȡ����ͬ��
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\������+ʱ��.xlsx',cycle_mean1,'time','B2'); %%%xlswrite('���ݱ��·��',cycle_mean1,'������ƣ����Զ��壬Ҳ�ɰ��ո����������ṩ��ʾ������е�λ�ý���д��','д�������ڱ���е���ʼλ��')  ���д����ʾд��CSM��������
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\������+ʱ��.xlsx',cycle_mean2,'time','B22');%%%���д����ʾд������������
