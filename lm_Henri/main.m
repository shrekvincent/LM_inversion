%%�����������
clc;
clear;
[single_trace,Tn]=GetSeisData();

%%Ԥ����
norm_seisdata=DataNorm(single_trace);

% % 
% %��ȡ�Ӳ�
wavelet=GetWavelet(norm_seisdata);

%%��ȡ����ϵ��
RefCoe=GetRefCoe(norm_seisdata,wavelet);


%%����ģ�ͽ���



