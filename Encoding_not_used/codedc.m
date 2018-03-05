function code=codedc(n)
if n==0
    ctg=0;
else
    ctg=floor(log2(abs(n))+1);
end

load dclht;
bcode=char(dclht(ctg+1));

code=dec2bin(abs(n));
if(n<0)
    for i=1:length(code)
        code(i)=char(97-code(i));
    end
end
if(n==0)
    code='';
end

code=[bcode code];
