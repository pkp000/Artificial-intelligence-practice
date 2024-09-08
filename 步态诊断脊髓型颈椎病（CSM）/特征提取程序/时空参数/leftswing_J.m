clear
clc
maindir='......\CSM'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
%%病人手术前后
q=1;
for k=3:5
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径，按照自己的文件路径即可
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%按照自己的文件名后缀即可
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
    data1 = num(:,4);
    data2 = num(:,14);
    data1 = data1( ~ isnan(data1));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    i=1;j=1;
    LOCATION1=[];LOCATION2=[];
    VALUE1=[];%VALUE2=[];
    for m=1:(length(location1)-1)
        LHEE_value = min(data1(location1(m):location1(m+1),1));
        A=find(data1(location1(m):location1(m+1),1) == LHEE_value);
        LOCATION(1,:) = location1(m)+min(A)-1;
        LOCATION1(i,:) = LOCATION(1,:);
%         VALUE1(i,:) = num(LOCATION,4);
        i=i+1;
    end
    for n=1:(length(location1)-1)
        LTOE_value = min(data2(location1(n):location1(n+1),1));
        B=find(data2(location1(n):location1(n+1),1) == LTOE_value);
        LOCATION(1,:) = location1(n)+min(B)-1;
        LOCATION2(j,:) = LOCATION(1,:);
%         VALUE2(j,:) = num(LOCATION,14);
        j=j+1;
    end
%     for p=1:length(LOCATION2)
%         swing(p,:) = abs((LOCATION2(p)-LOCATION1(p))/(location1(p+1)-location1(p)));
%     end
    if length(LOCATION1)==length(location1)
        LOCATION1 = LOCATION1(1:(length(LOCATION1)-1),1);
        LOCATION2 = LOCATION2(1:(length(LOCATION2)-1),1);
        leftswing1(q,:) = abs(sum(LOCATION2-LOCATION1)/(location1(length(location1))-location1(1)));
    elseif length(LOCATION1)>length(location1)
        LOCATION1 = LOCATION1(1:(length(LOCATION1)-2),1);
        LOCATION2 = LOCATION2(1:(length(LOCATION2)-2),1);
        leftswing1(q,:) = abs(sum(LOCATION2-LOCATION1)/(location1(length(location1))-location1(1)));
    else
        leftswing1(q,:) = abs(sum(LOCATION2-LOCATION1)/(location1(length(location1))-location1(1)));
    end
    q=q+1;
    disp(k)
end
maindir='......\HC'; %读取主文件夹
subdir  = dir( maindir );%读取子文件夹
q=1;
for k=3:92
    subdirpath = fullfile( maindir, subdir(k).name, '1' );%进入子文件夹内部路径，按照自己的文件路径即可
    dirOutput = dir(fullfile(subdirpath,'*gait.xlsx'));%%按照自己的文件名后缀即可
    filename=dirOutput.name;
    [subdirpath,'\',filename];
    num=xlsread([subdirpath,'\',filename],1);  %%从第一张表格中提取数据
    data1 = num(:,4);
    data2 = num(:,14);
    data1 = data1( ~ isnan(data1));
    [value1,location1] = findpeaks(data1,'minpeakheight',0.07);
    i=1;j=1;
    LOCATION1=[];LOCATION2=[];
    VALUE1=[];%VALUE2=[];
    for m=1:(length(location1)-1)
        LHEE_value = min(data1(location1(m):location1(m+1),1));
        A=find(data1(location1(m):location1(m+1),1) == LHEE_value);
        LOCATION(1,:) = location1(m)+min(A)-1;
        LOCATION1(i,:) = LOCATION(1,:);
%         VALUE1(i,:) = num(LOCATION,4);
        i=i+1;
    end
    for n=1:(length(location1)-1)
        LTOE_value = min(data2(location1(n):location1(n+1),1));
        B=find(data2(location1(n):location1(n+1),1) == LTOE_value);
        LOCATION(1,:) = location1(n)+min(B)-1;
        LOCATION2(j,:) = LOCATION(1,:);
%         VALUE2(j,:) = num(LOCATION,14);
        j=j+1;
    end
%     for p=1:length(LOCATION2)
%         swing(p,:) = abs(sum(LOCATION2-LOCATION1)/(location1(length(location1))-location1(1)));
%     end
    if length(LOCATION1)==length(location1)
        LOCATION1 = LOCATION1(1:(length(LOCATION1)-1),1);
        LOCATION2 = LOCATION2(1:(length(LOCATION2)-1),1);
        leftswing2(q,:) = abs(sum(LOCATION2-LOCATION1)/(location1(length(location1))-location1(1)));
    elseif length(LOCATION1)>length(location1)
        LOCATION1 = LOCATION1(1:(length(LOCATION1)-2),1);
        LOCATION2 = LOCATION2(1:(length(LOCATION2)-2),1);
        leftswing2(q,:) = abs(sum(LOCATION2-LOCATION1)/(location1(length(location1))-location1(1)));
    else
        leftswing2(q,:) = abs(sum(LOCATION2-LOCATION1)/(location1(length(location1))-location1(1)));
    end
    q=q+1;
    disp(k)
end
% xlswrite('C:\Users\jxy\Desktop\CSM数据库\数据\非线性+时空.xlsx',leftswing1,'time','I2');
% xlswrite('C:\Users\jxy\Desktop\CSM数据库\数据\非线性+时空.xlsx',leftswing2,'time','I92');
