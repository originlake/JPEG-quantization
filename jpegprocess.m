function I1=jpegprocess(I,quality)
%JPEG quantization simulation.
%Apply quantization and dequantization process for an input image, return
%reconstructed image.
%The function accepts:
%I            ,for input image
%quality      ,for compression quality
%The funcion returns:
%I1           ,for reconstruted image
%
%Shuo Zhong, 4/25/2017
if (nargin < 1)
  I=imread('lena256.bmp');
end

if (nargin < 2)
  quality=50;
end
%% quantization
k=numel(size(I));
if k>2
    M=rgb2ycbcr(I);            %RGB transform to YCbCr
    M=double(M);
    Y=M(:,:,1)-128;
    U=M(:,:,2)-128;
    V=M(:,:,3)-128;
else
    Y=double(I)-128;
end
D=dctmtx(8);
a=jpeg_qtable(quality,0,1);  %JPEG luminance quantization table 
b=jpeg_qtable(quality,1,1);  %JPEG chrominance quantization table

BY=blkproc(Y,[8,8],'P1*x*P2',D,D');     %block and apply DCT
BY=blkproc(BY,[8,8],'round(x./P1)',a);
if k>2
    BU=blkproc(U,[8,8],'P1*x*P2',D,D');
    BV=blkproc(V,[8,8],'P1*x*P2',D,D');
    BU=blkproc(BU,[8,8],'round(x./P1)',b);
    BV=blkproc(BV,[8,8],'round(x./P1)',b);      
end
%% Encoding process won't cause loss in data, hence skip
%% Dequantizaion and reconstruction
BY=blkproc(BY,[8,8],'x.*P1',a);       %dequantization
Y=blkproc(BY,[8,8],'P1*x*P2',D',D)+128;
if k>2
    BU=blkproc(BU,[8,8],'x.*P1',b);
    BV=blkproc(BV,[8,8],'x.*P1',b);
    U=blkproc(BU,[8,8],'P1*x*P2',D',D)+128;
    V=blkproc(BV,[8,8],'P1*x*P2',D',D)+128;
end

if k>2
    M=cat(3,Y,U,V);                       %reconstruction
    M=uint8(M);
    I1=ycbcr2rgb(M);
else 
    I1=uint8(Y);
end
