clear
clc
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\���ݣ�45CSM+45HC��\CSM'; %��ȡ���ļ���
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
    velocity(1,:) = abs((num(location1(length(location1)),3)-num(location1(1),3))/((location1(length(location1))-location1(1))/200));
    velocity1(i,:) = velocity(1,:);
    i=i+1;
    disp(k-2)
end
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\���ݣ�45CSM+45HC��\HC'; %��ȡ���ļ���
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
    velocity(1,:) = abs((num(location1(length(location1)),3)-num(location1(1),3))/((location1(length(location1))-location1(1))/200));
    velocity2(i,:) = velocity(1,:);
    i=i+1;
    disp(k-2)
end
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\������+ʱ��.xlsx',velocity1,'time','E2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\������+ʱ��.xlsx',velocity2,'time','E22');
