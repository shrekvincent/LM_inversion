function fvalue=fun(imp,nimp)
%%imp：初始阻抗值
%%nimp:阻抗长度

%%反射系数与子波摺积合成地震记录
% N_flat=N_flat+1;
ref=zero(nimp);
ref(nimp/2)=rand(0,1);
ref(nimp/3)=rand(0,1);
ref(nimp/4)=rand(0,1);
ref(nimp/5)=rand(0,1);
ref(nimp/6)=rand(0,1);

%%获取初始波阻抗
function Reflectivity2Impedance(ref,imp)
for i=0:1:length(ref)
    imp=sum(ref,i);
end


subplot(2,2,1);plot(data);title('原始地震记录');
dt=0.001;fs=1/dt;
WL=125;%子波长度
f=35;
k=-(WL-1)/2:WL/2;
w=(1-2.*(pi*f*0.001.*k).^2).*exp(-(pi*f*0.001.*k).^2);%雷克子波表达式x=data;
Theory_s=conv(ref,w);

%%合成记录与地震数据拟合 sum1 = (theory-data)**2
sum1=0.0;TMS=0.0;
for i=0:1:nimp
    sum1=sum1+pow((Theory_s-data),2);
    TMS=TMs+pow(data,2);
    TMS=TMS/nimp;
    obj_seis=sum1/TMS;
end

%%与初始模型拟合
sum2=0;LMS=0;
for i=0:1:nimp
    sum2=sum2+pow((imp-model),2);
    LMS=LMS+pow(model,2);
    LMS=LMS/nimp;
    obj_model=sum2/LMS;
end

%%目标函数
sum3=0;
for i=0:1:nimp
    sum3=sum3+abs(ref(i));
    obj_sparse=sum3;
    lamda=1;
    alpha_seis=_alpha_seis;
    alpha_model=_alpha_seis;
    alpha_sparse=_alpha_sparse;
    fvalue=-(alpha_seis*obj_seis+alpha_model*obj_model+alpha_sparse*obj_sparse);
end


    