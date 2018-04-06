function RefCoe=GetRefCoe(single_trace,wavelet)%%最小平方反滤波  脉冲反褶积

% [single_trace,Tn]=GetSeisData();
% 
% %%预处理
% norm_seisdata=DataNorm(single_trace);
% 
% % % 
% % %提取子波
% wavelet=GetWavelet(norm_seisdata);

[M,N]=size(signal_trace);
y=signal_trace;
N=length(wavelet);
p=0.01%预白噪
c=xcorr(single_trace);
c(M)=(1+p)*c(M);
Y=toeplitz(c(M:2*M-1));
X=zeros(M,1);
X(1)=1;
a=Y\X;
b1=conv(a,single_trace);

for i=1:M-N+1
    T(i)=b1(i);
end
% RefCoe=T;
% plot(RefCoe,'r');

% [RefCoe,R]=deconv(single_trace,wavelet);
% % plot(RefCoe);
% title('反射系数');

A1=zeros(M,M-N+1);
for i=1:M-N+1
    for j=1:N
        A1(i+j-1,i)=wavelet(j);
    end
end

sgama=0.01;
% delta=0.1;
lamda=2;
Q1=diag((sgama^2.+diag(T')*T')/(2*lamda));
M1=A1'*A1+Q1;
Y1=y'*A1;
Q2=inv(M1)*Y1';
% while norm(A1*Q2-y)>0.1
%     TS=Q2;
%     QS=diag((sgama^2.+diag(TS)*TS)/(2*lamda));
%     MS=A1'*A1+QS;
%     YS=y'*A1;
%     Q2=inv(MS)*YS';   
% end
mm=norm(A1*Q2-y);
RefCoe=Q2;
plot(RefCoe);
title('反射系数')

