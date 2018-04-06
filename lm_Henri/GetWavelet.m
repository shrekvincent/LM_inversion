function [wavelet]=GetWavelet(single_trace)
num_wavelet=125;
x=single_trace;
[M,N]=size(single_trace);
y=abs(fft(x));
for i=1:M
    y(i)=(y(i)-min(y))/(max(y)-min(y));
end
y1=zeros(1,M);
y1=fft(x);%���޻�������Ҷ�任
z=log(y1);%��ȡ�����
z1=ifft(z);%��������Ҷ���任
c1=[ones(1,15),zeros(1,M-30),ones(1,15)];%���һ��ʱ��
wl=z1.*c1';%��ȡ������ʱ�����ǰ��ӽ���0��һ������
wl=fft(wl);%�����и���Ҷ�任���õ�������
wl=exp(wl);%��ȡ��ָ�����õ��Ӳ���
wl=ifft(wl);%Ȼ��������Ҷ���任�õ�ʱ����ĵ����Ӳ�
w0=real(wl);

for i=1:(num_wavelet-1)/2
    w1(i)=w0((num_wavelet+1)/2-i);
end
for i=(num_wavelet+1)/2:num_wavelet
    w1(i)=w0(i-(num_wavelet-1)/2);
end
pm=max(abs(w1));
for i=1:num_wavelet
    w1(i)=w1(i)/pm;
end

for i=1:num_wavelet
    ww(i)=w1(i);
end
wavelet=ww;
figure();
plot(wavelet)