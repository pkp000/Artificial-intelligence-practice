function [max_1,min_1,peak,p2p,mean_1,averageAmplitude,rootAmplitude,var_1,std_1,rms] = timeDomainFeatures( src)
% 计算时域统计特征
% src  N*1维矩阵 是要计算特征的源信号

if nargin>2
     error(message('参数有误，只有只能是一个或2个输入参数'));
end

%////////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
max_1=max(src);%1.最大值
min_1=min(src);%2.最小值
peak=max(abs(src)); %3.峰值
p2p=max(src)-min(src);%4.峰峰值
mean_1=mean(src);%5.均值
averageAmplitude=mean(abs(src));%6.绝对平均值（平均幅值）
rootAmplitude=mean(sqrt(abs(src)))^2;%7.方根幅值
var_1=var(src,1);%8.方差  有偏
std_1=std(src,1);%9.标准差
rms=sqrt(sum(src.^2)/length(src));%10.有效值（均方根）
kurtosis_1=kurtosis(src);%11.峭度
skewness_1=skewness(src);%12.偏度
shapeFactor=rms/averageAmplitude;%13.波形因子
peakingFactor=peak/rms;%14.峰值因子（波峰因子）
pulseFactor=peak/averageAmplitude;%15.脉冲因子
marginFactor=peak/rootAmplitude;%16.裕度因子
clearanceFactor=peak/rms^2;%17.余隙因子


%//////////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% if nargin==2
%      switch(option)
%          case 'max'
%              disp('max value=');
%              disp(timestruct.max);
%          case 'min'
%              disp('min value=');
%              disp(timestruct.min);           
%      end 
% end 

end

