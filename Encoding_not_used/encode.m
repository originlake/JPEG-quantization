%jpeg encoder
function code=encode(I)
I=randi([0,255],16);
z=[ 1 9 2 3 10 17 25 18 11 4 5 12 19 26 33 41 34 27 20 13 6 7 14 21 28 35 42 49 57 50 43 36 29 22 15 8  16 23 30 37 44 51 58 59 52 45 38 31 24 32 39 46 53 60 61 54 47 40 48 55 62 63 56 64];             %zigzag–Ú

[m,n]=size(I);
blkrow=m/8;
blkcol=n/8;
for i=1:blkrow
    tmp=im2col(I(8*i-7:8*i,:),[8 8],'distinct');
    if i==1
        I1=tmp;
    else
        I1=[I1 tmp];
    end
end

bn=blkrow*blkcol;
I1=I1(z,:);
for i=bn:-1:2
    I1(1,i)=I1(1,i)-I1(1,i-1);
end
code=char;
bn=1;
for j=1:bn
    k=find(I1(:,j),1,'last');
    if isempty(k)
        code=[code '1010'];
        continue;
    end
    if k==1
        code=[code codedc(I1(1,j)) '1010'];
        continue;
    end
    code=[code codedc(I1(1,j))];
    i=2;
    while i<=k
        t=0;
        while I1(i,j)==0
            t=t+1;
            i=i+1;
            if t==16
                code=[code '11111111001'];
                t=0;
            end
        end
        code=[code codeac(t,I1(i,j))];
        i=i+1;
    end
    code=[code '1010'];
end


        
        
    
    




