function [single_trace,Tn]=GetSeisData()

%%% 直接读取txt文件 flag=1
% [fname,pname]=uigetfile('*.dat','Sample Dialog Box');
% data=load(fname);
% x=data;

%%读取sgy文件，并选取任一道数据
[fname,pname] = uigetfile('*.sgy','Sample Dialog Box')
segyid=fopen(fname);
% segyid=fname;
 if ~segyid
   { 
       disp('can''t open file!'); 
       exit; 
   } ;
 end 
fseek(segyid,3220,'bof');  %读取采样点数 
SI=fread(segyid,1,'int16','b') ;
fseek(segyid,3216,'bof');  %读取采样率 
Sp=fread(segyid,1,'int16','b') ;
fseek(segyid,0,'eof'); %计算总文件字节数 
BytesInFile=ftell(segyid);
Tn=(BytesInFile-3600)/(SI*4+240); %计算道数 

% fclose(segyid);  
seismic_data=zeros(SI,Tn);   
% segyid=fopen('YT429.sgy','rb'); 
% [fname,pname] = uigetfile('*.sgy','Sample Dialog Box')
% segyid=fopen(fname);
%  if ~segyid 
%    { 
%        disp('can''t open file!'); 
%        exit; 
%    } ;
%  end 
%读取地震数据 
 for n=1:Tn 
        fseek(segyid,3600+n*240+(n-1)*SI*4,'bof'); 
        seismic=fread(segyid ,[1 SI],'uint32','b');
        seismic_data(:,n)=ibm2num(uint32(seismic'));
 end
fclose(segyid);
 h=0:Sp/1000:Sp/1000*(SI-1);
for n=1:Tn 
  q=100*n*ones(SI,Tn);
       c=q(:,n);
       seismic_data11=seismic_data(:,n);
       seismic_data2=seismic_data11+c;
end;
imagesc(seismic_data);colormap(gray);%%灰度图
figure();
% imagesc(seismic_data);colormap(hsv);%%伪彩图
% figure();
% wiggle(seismic_data);%%地震数据波形图
 
%  hold on;
% wiggle(seismic_data);
xlabel('炮间距');
ylabel('采样点时间/s');
title('地震剖面图') ; 
% fclose(segyid);  
single_trace=seismic_data(:,Tn*0.5);
figure();plot(single_trace);



