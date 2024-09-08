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
    for j=1:(length(location1)-1)
        cycle_v(j,:) = (location1(j+1)-location1(j))/200;
    end
    Cycle_v(1,:) = std(cycle_v)/mean(cycle_v);
    Cycle_v1(i,:) = Cycle_v(1,:);
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
    for j=1:(length(location1)-1)
        cycle_v(j,:) = (location1(j+1)-location1(j))/200;
    end
    Cycle_v(1,:) = std(cycle_v)/mean(cycle_v);
    Cycle_v2(i,:) = Cycle_v(1,:);
    i=i+1;
    disp(k)
end
% xlswrite('C:\Users\jxy\Desktop\CSM数据库\非线性+时空\数据.xlsx',Cycle_v1,'time','H2');
% xlswrite('C:\Users\jxy\Desktop\CSM数据库\非线性+时空\数据.xlsx',Cycle_v2,'time','H92');
