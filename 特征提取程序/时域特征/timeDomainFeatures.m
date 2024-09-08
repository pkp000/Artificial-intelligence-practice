function [max_1,min_1,peak,p2p,mean_1,averageAmplitude,rootAmplitude,var_1,std_1,rms] = timeDomainFeatures( src)
% ����ʱ��ͳ������
% src  N*1ά���� ��Ҫ����������Դ�ź�

if nargin>2
     error(message('��������ֻ��ֻ����һ����2���������'));
end

%////////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
max_1=max(src);%1.���ֵ
min_1=min(src);%2.��Сֵ
peak=max(abs(src)); %3.��ֵ
p2p=max(src)-min(src);%4.���ֵ
mean_1=mean(src);%5.��ֵ
averageAmplitude=mean(abs(src));%6.����ƽ��ֵ��ƽ����ֵ��
rootAmplitude=mean(sqrt(abs(src)))^2;%7.������ֵ
var_1=var(src,1);%8.����  ��ƫ
std_1=std(src,1);%9.��׼��
rms=sqrt(sum(src.^2)/length(src));%10.��Чֵ����������
kurtosis_1=kurtosis(src);%11.�Ͷ�
skewness_1=skewness(src);%12.ƫ��
shapeFactor=rms/averageAmplitude;%13.��������
peakingFactor=peak/rms;%14.��ֵ���ӣ��������ӣ�
pulseFactor=peak/averageAmplitude;%15.��������
marginFactor=peak/rootAmplitude;%16.ԣ������
clearanceFactor=peak/rms^2;%17.��϶����


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

