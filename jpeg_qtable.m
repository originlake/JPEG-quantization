function table=jpeg_qtable(q,c)
%Returns JPEG quantization table
%
%The function accepts:
%q   JPEG quality for 1 to 100, bad to good
%c   Choosing the table, 0 for lunminance table, 1 for chrominance table
%
%From jpegtbx-1.4
if(nargin<1)  q=50; end
if(nargin<2)  c=0; end
%% convert quality
if (quality <= 0) quality = 1; end
if (quality > 100) quality = 100; end
if (quality < 50)
  quality = 5000 / quality;
else
  quality = 200 - quality*2;
end
%% generating table
switch(c)
    case 0
     table=[16,11,10,16,24,40,51,61;
        12,12,14,19,26,58,60,55;
        14,13,16,24,40,57,69,56;
        14,17,22,29,51,87,80,62;
        18,22,37,56,68,109,103,77;
        24,35,55,64,81,104,113,92;
        49,64,78,87,103,121,120,101;
        72,92,95,98,112,100,103,99];  %JPEG luminance quantization table
    case 1
     table=[17,18,24,47,99,99,99,99;
        18,21,26,66,99,99,99,99;
        24,26,56,99,99,99,99,99;
        47,66,99,99,99,99,99,99;
        99,99,99,99,99,99,99,99;
        99,99,99,99,99,99,99,99;
        99,99,99,99,99,99,99,99;
        99,99,99,99,99,99,99,99];   %JPEG chrominance quantization table
end

table=floor((table*q+50)/100);
table(table<1)=1;
table(table>255)=255;
