%%输入地震数据
clc;
clear;
[single_trace,Tn]=GetSeisData();

%%预处理
norm_seisdata=DataNorm(single_trace);

% % 
% %提取子波
wavelet=GetWavelet(norm_seisdata);

%%求取反射系数
RefCoe=GetRefCoe(norm_seisdata,wavelet);


%%反演模型建立



