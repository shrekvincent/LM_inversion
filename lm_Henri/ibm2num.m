function x=ibm2num(b)

x=repmat(NaN,size(b));
sign=bitget(b,32);                            % get sign from first bit
sign=double(sign);
% format hex
exp=bitand(b,uint32(hex2dec('7f000000')));    % get exponent from first byte, last 7 bits
exp=bitshift(exp,-24);
%format long
exp=double(exp)- 64;                          % remove bias from exponent 
%format hex
frac=bitand(b,uint32(hex2dec('00ffffff')));   % get mantissa from last 3 bytes
%format long
frac=double(frac);
frac=frac/2^24;
x=(1-2*sign).*16.^exp .* frac;
err = frac==0 & (exp~=-64 | sign~=0);         % bias removal is incorrect for zero
if any(err)
   % TMH 19/06/2003
   disp(['WARNING : ',mfilename,' Invalid zero input --> Sure data are IBM FLOAT formatted ?'])	
   return;							     						      
end
err = frac~=0 & (frac<1/16 | frac>=1);
if any(err)
   % TMH 19/06/2003
   disp(['WARNING : ',mfilename,' Invalid mantissa input --> Sure data are IBM FLOAT formatted ?'])	
   return;				      
end  
