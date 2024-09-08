clear
clc
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\数据（45CSM+45HC）\CSM'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
%%病人手术前后
i=1;
for k=3:22
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径，按照自己的文件路径即可
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%按照自己的文件名后缀即可
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
    data1 = num(:,4);
    data1 = data1( ~ isnan(data1));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    stride_length(1,:) = abs((num(location1(length(location1)),3)-num(location1(1),3))/(length(location1)-1));
    stride_length1(i,:) = stride_length(1,:);
    i=i+1;
    disp(k-2)
end
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\数据（45CSM+45HC）\HC'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
i=1;
for k=3:17
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径，按照自己的文件路径即可
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%按照自己的文件名后缀即可
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
    data1 = num(:,4);
    data1 = data1( ~ isnan(data1));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    stride_length(1,:) = abs((num(location1(length(location1)),3)-num(location1(1),3))/(length(location1)-1));
    stride_length2(i,:) = stride_length(1,:);
    i=i+1;
    disp(k-2)
end
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\非线性+时空.xlsx',stride_length1,'time','G2');
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\非线性+时空.xlsx',stride_length2,'time','G22');
