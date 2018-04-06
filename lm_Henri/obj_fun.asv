function []=obj_fun(single_trace,)
%%建立目标函数
%%目标函数由三项构成，分别是：地震数据拟合，模型约束项 ，稀疏约束项
alpha_seis=1;%地震数据拟合权重
alpha_model=1-alpha_seis;%模型约束权重
alpha_sparse=10;%稀疏约束权重
lamda=1;


%%合成记录与地震数据拟合 sum1 = (theory-data)**2
sum1=0.0;TMS=0.0;LMS=0;
[M,N]=size(single_trace);
nimp=M;
for i=0:1:nimp
    sum1=sum1+pow((x(i)-S(i)),2.0); %%S(i)重点要求的
end

for i=0:1:nimp
    TMS=TMS+pow(x(i),2.0);
    TMS=TMs/nimp;
    obj_seis=sum1/TMS;
end

%%与初始模型拟合
sum2=0; LMS=0;
for i=0:1:nimp;
    sum2=sum2+pow(imp(i)-model(i),2.0);%%初始阻抗怎么获得
end

for i=0:1:nimp
    LMS=LMS+pow(model(i),2.0);
    LMS=LMs/nimp;
    obj_model=sum2/LMS;
end

%%目标函数
sum3=0.0;
for i=0:1:nimp
    sum3=sum3+abs(res(i));
    obj_sparse=sum3;
end