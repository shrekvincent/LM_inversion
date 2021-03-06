function [wavelet]=GetWavelet(single_trace)
num_wavelet=125;
x=single_trace;
[M,N]=size(single_trace);
y=abs(fft(x));
for i=1:M
    y(i)=(y(i)-min(y))/(max(y)-min(y));
end
y1=zeros(1,M);
y1=fft(x);%对褶积做傅里叶变换
z=log(y1);%并取其对数
z1=ifft(z);%再做傅里叶反变换
c1=[ones(1,15),zeros(1,M-30),ones(1,15)];%设计一个时窗
wl=z1.*c1';%截取复赛谱时间域的前面接近于0的一段数据
wl=fft(wl);%并进行傅里叶变换，得到对数谱
wl=exp(wl);%再取其指数，得到子波谱
wl=ifft(wl);%然后做傅里叶反变换得到时间域的地震子波
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