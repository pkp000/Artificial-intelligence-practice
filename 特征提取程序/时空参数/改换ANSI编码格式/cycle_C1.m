clear
clc
%%%%%%%%读取主文件夹，本实验中为包含受试者数据的“CSM”和“HC”文件夹（按照实际情况修改，其他时空参数提取程序以及时域特征提取程序同理）
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\数据（45CSM+45HC）\CSM'; 
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
    cycle_mean(1,:) = ((location1(length(location1),1)-location1(1,1))/200)/(length(location1)-1);
    cycle_mean1(i,:) = cycle_mean(1,:);
    i=i+1;
    disp(k-2)
end
maindir='C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\数据（45CSM+45HC）\HC'; %读取主文件夹（按照实际情况修改）
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
    cycle_mean(1,:) = ((location1(length(location1),1)-location1(1,1))/200)/(length(location1)-1);
    cycle_mean2(i,:) = cycle_mean(1,:);
    i=i+1;
    disp(k-2)
end
%%%%%将数据写入表格，示例表格已提供,其他时空参数提取程序以及时域特征提取程序同理
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\非线性+时空.xlsx',cycle_mean1,'time','B2'); %%%xlswrite('数据表格路径',cycle_mean1,'表格名称，可自定义，也可按照该特征在所提供的示例表格中的位置进行写入','写入数据在表格中的起始位置')  此行代码表示写入CSM病人数据
xlswrite('C:\Users\pkp\Desktop\kunpeng_pei_AIpractice\特征提取程序\特征提取结果\非线性+时空.xlsx',cycle_mean2,'time','B22');%%%此行代码表示写入正常人数据
