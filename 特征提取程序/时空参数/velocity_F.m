clear
clc
maindir='......\CSM'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
%%病人手术前后
i=1;
for k=3:92
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径，按照自己的文件路径即可
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%按照自己的文件名后缀即可
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
    data1 = num(:,4);
    data1 = data1( ~ isnan(data1));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    velocity(1,:) = abs((num(location1(length(location1)),3)-num(location1(1),3))/((location1(length(location1))-location1(1))/200));
    velocity1(i,:) = velocity(1,:);
    i=i+1;
    disp(k)
end
maindir='......\HC'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
i=1;
for k=3:92
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径，按照自己的文件路径即可
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%按照自己的文件名后缀即可
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
    data1 = num(:,4);
    data1 = data1( ~ isnan(data1));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    velocity(1,:) = abs((num(location1(length(location1)),3)-num(location1(1),3))/((location1(length(location1))-location1(1))/200));
    velocity2(i,:) = velocity(1,:);
    i=i+1;
    disp(k)
end
% xlswrite('C:\Users\jxy\Desktop\CSM数据库\数据\非线性+时空.xlsx',velocity1,'time','E2');
% xlswrite('C:\Users\jxy\Desktop\CSM数据库\数据\非线性+时空.xlsx',velocity2,'time','E92');
