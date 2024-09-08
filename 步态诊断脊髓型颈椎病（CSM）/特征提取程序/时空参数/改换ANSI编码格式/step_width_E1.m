clear
clc
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\数据（45CSM+45HC）\CSM'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
p=1;
%%病人手术前后
for k=3:22
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径，按照自己的文件路径即可
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%按照自己的文件名后缀即可
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
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
    value_combine=[num(LOCATION1,2);num(LOCATION2,7)];
    value_combine=sort(value_combine);
    for q=1:(length(value_combine)-1)
        sum=sum+abs(value_combine(q+1)-value_combine(q));
    end
    step_width(1,:) = sum/(length(value_combine)-1);
    step_width1(p,:) = step_width(1,:);
    p=p+1;
    disp(k-2)
end

maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\数据（45CSM+45HC）\HC'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
p=1;
for k=3:17
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径，按照自己的文件路径即可
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%按照自己的文件名后缀即可
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
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
    value_combine=[num(LOCATION1,2);num(LOCATION2,7)];
    value_combine=sort(value_combine);
    for q=1:(length(value_combine)-1)
        sum=sum+abs(value_combine(q+1)-value_combine(q));
    end
    step_width(1,:) = sum/(length(value_combine)-1);
    step_width2(p,:) = step_width(1,:);
    p=p+1;
    disp(k-2)
end
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\非线性+时空.xlsx',step_width1,'time','D2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\非线性+时空.xlsx',step_width2,'time','D22');