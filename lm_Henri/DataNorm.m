function [Norm_seisdata]=DataNorm(SeisData)
Maxx=max(SeisData);
Minn=min(SeisData);
% L=length(single_trace)
[M,N]=size(SeisData);
Norm_Seisdata=zeros(M,N);
for i=1:1:M
    Norm_Seisdata(i)=SeisData(i)/(Maxx-Minn);
end
Norm_seisdata=Norm_Seisdata();
figure();
plot(Norm_seisdata);
title('预处理后的地震数据');
