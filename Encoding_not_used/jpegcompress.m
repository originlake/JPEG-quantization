function [A,len]=jpegcompress(quality,I)
%Apply JPEG compression algorithm from beginning to huffman encoding
%!!not fully implemented
M=rgb2ycbcr(I);            %RGB to YCbCr
M=double(M);
Y=M(:,:,1)-128;
U=M(:,:,2)-128;
V=M(:,:,3)-128;

D=dctmtx(8);
BY=blkproc(Y,[8,8],'P1*x*P2',D,D');     %block and apply DCT
BU=blkproc(U,[8,8],'P1*x*P2',D,D');
BV=blkproc(V,[8,8],'P1*x*P2',D,D');

if (quality <= 0) quality = 1; end
if (quality > 100) quality = 100; end
if (quality < 50)
  quality = 5000 / quality;
else
  quality = 200 - quality*2;
end

a=[16,11,10,16,24,40,51,61;
   12,12,14,19,26,58,60,55;
   14,13,16,24,40,57,69,56;
   14,17,22,29,51,87,80,62;
   18,22,37,56,68,109,103,77;
   24,35,55,64,81,104,113,92;
   49,64,78,87,103,121,120,101;
   72,92,95,98,112,100,103,99];  %JPEG luminance quantization table
b=[17,18,24,47,99,99,99,99;
    18,21,26,66,99,99,99,99;
    24,26,56,99,99,99,99,99;
    47,66,99,99,99,99,99,99;
    99,99,99,99,99,99,99,99;
    99,99,99,99,99,99,99,99;
    99,99,99,99,99,99,99,99;
    99,99,99,99,99,99,99,99];   %JPEG chrominance quantization table

BY=blkproc(BY,[8,8],'round(x./P1)',a);
BU=blkproc(BU,[8,8],'round(x./P1)',b);
BV=blkproc(BV,[8,8],'round(x./P1)',b);       %quantization

A=encode(BY);










