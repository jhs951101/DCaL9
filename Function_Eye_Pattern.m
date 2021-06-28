function Function_Eye_Pattern(x, Rb, fs, Flag)

Tb = 1/Rb;
ts = 1/fs;

Nbit = fs/Rb;

total_len = length(x);
bitlen = total_len/Nbit;

num_eye = 2;  % num_eye: 몇 비트씩 Eye Diagram에 표시할 것인지를 의미하는 변수

y = reshape(x, num_eye*Nbit, bitlen/num_eye);  % y: bit 값들을 num_eye*Nbit 행 bitlen/num_eye 열로 재구성한 행렬
y = y';

Ttime = 0:ts:num_eye*Tb-ts;
figure
for ii = 2:bitlen/2  % bit 값이 재구성된 행렬을 한 행마다 그림으로써 Eye Diagram 형태가 되는 것임
    if nargin == 4 && Flag == 1
        stairs(Ttime, y(ii,:)); hold on;
    else
        plot(Ttime, y(ii,:)); hold on;
    end
end
