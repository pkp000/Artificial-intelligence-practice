clear
clc
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\���ݣ�45CSM+45HC��\CSM'; %��ȡ���ļ���
subdir  = dir( maindir );%��ȡ���ļ���
p=1;
%%��������ǰ��
for k=3:22
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%�������ļ����ڲ�·���������Լ����ļ�·������
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%�����Լ����ļ�����׺����
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%�ӵ�һ�ű������ȡ����
    i=1;j=1;sum = 0;
    data1 = num(:,4);
    data2 = num(:,9);
    data1 = data1( ~ isnan(data1));
    data2 = data2( ~ isnan(data2));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    [value2,location2] = findpeaks(data2,'minpeakheight',0.07);
    LOCATION1=[];LOCATION2=[];
    for m=1:(length(location1)-1)
        LHEE_value = min(data1(location1(m):location1(m+1),1));
        A=find(data1 == LHEE_value);
        LOCATION(1,:) = min(A);
        LOCATION1(i,:) = LOCATION(1,:);
        i=i+1;
    end
    for n=1:(length(location2)-1)
        RHEE_value = min(data2(location2(n):location2(n+1),1));
        B=find(data2 == RHEE_value);
        LOCATION(1,:) = min(B);
        LOCATION2(j,:) = LOCATION(1,:);
        j=j+1;
    end
    Location = [LOCATION1;LOCATION2];
    Location = sort(Location);
    cadence(1,:) = (length(Location)-1)/((Location(length(Location))-Location(1))/200);
    cadence1(p,:) = cadence(1,:);
    p=p+1;
    disp(k)
end
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\���ݣ�45CSM+45HC��\HC'; %��ȡ���ļ���
subdir  = dir( maindir );%��ȡ���ļ���
p=1;
for k=3:17
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%�������ļ����ڲ�·���������Լ����ļ�·������
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%�����Լ����ļ�����׺����
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%�ӵ�һ�ű������ȡ����
    i=1;j=1;sum = 0;
    data1 = num(:,4);
    data2 = num(:,9);
    data1 = data1( ~ isnan(data1));
    data2 = data2( ~ isnan(data2));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    [value2,location2] = findpeaks(data2,'minpeakheight',0.07);
    LOCATION1=[];LOCATION2=[];
    for m=1:(length(location1)-1)
        LHEE_value = min(data1(location1(m):location1(m+1),1));
        A=find(data1 == LHEE_value);
        LOCATION(1,:) = min(A);
        LOCATION1(i,:) = LOCATION(1,:);
        i=i+1;
    end
    for n=1:(length(location2)-1)
        RHEE_value = min(data2(location2(n):location2(n+1),1));
        B=find(data2 == RHEE_value);
        LOCATION(1,:) = min(B);
        LOCATION2(j,:) = LOCATION(1,:);
        j=j+1;
    end
    Location = [LOCATION1;LOCATION2];
    Location = sort(Location);
    cadence(1,:) = (length(Location)-1)/((Location(length(Location))-Location(1))/200);
    cadence2(p,:) = cadence(1,:);
    p=p+1;
    disp(k)
end
 xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\������+ʱ��.xlsx',cadence1,'time','F2');
 xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\������ȡ����\������ȡ���\������+ʱ��.xlsx',cadence2,'time','F92');
