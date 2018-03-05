function code=codeac(t,n)

ctg=floor(log2(abs(n))+1);

load lht;
bcode=char(lht(t+1,ctg));

code=dec2bin(abs(n));
if(n<0)
    for i=1:length(code)
        code(i)=char(97-code(i));
    end
end

code=[bcode code];