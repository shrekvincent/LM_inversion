function [single_trace,Tn]=GetSeisData()

%%% ֱ�Ӷ�ȡtxt�ļ� flag=1
% [fname,pname]=uigetfile('*.dat','Sample Dialog Box');
% data=load(fname);
% x=data;

%%��ȡsgy�ļ�����ѡȡ��һ������
[fname,pname] = uigetfile('*.sgy','Sample Dialog Box')
segyid=fopen(fname);
% segyid=fname;
 if ~segyid
   { 
       disp('can''t open file!'); 
       exit; 
   } ;
 end 
fseek(segyid,3220,'bof');  %��ȡ�������� 
SI=fread(segyid,1,'int16','b') ;
fseek(segyid,3216,'bof');  %��ȡ������ 
Sp=fread(segyid,1,'int16','b') ;
fseek(segyid,0,'eof'); %�������ļ��ֽ��� 
BytesInFile=ftell(segyid);
Tn=(BytesInFile-3600)/(SI*4+240); %������� 

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
%��ȡ�������� 
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
imagesc(seismic_data);colormap(gray);%%�Ҷ�ͼ
figure();
% imagesc(seismic_data);colormap(hsv);%%α��ͼ
% figure();
% wiggle(seismic_data);%%�������ݲ���ͼ
 
%  hold on;
% wiggle(seismic_data);
xlabel('�ڼ��');
ylabel('������ʱ��/s');
title('��������ͼ') ; 
% fclose(segyid);  
single_trace=seismic_data(:,Tn*0.5);
figure();plot(single_trace);



