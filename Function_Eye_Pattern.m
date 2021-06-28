function Function_Eye_Pattern(x, Rb, fs, Flag)

Tb = 1/Rb;
ts = 1/fs;

Nbit = fs/Rb;

total_len = length(x);
bitlen = total_len/Nbit;

num_eye = 2;  % num_eye: �� ��Ʈ�� Eye Diagram�� ǥ���� �������� �ǹ��ϴ� ����

y = reshape(x, num_eye*Nbit, bitlen/num_eye);  % y: bit ������ num_eye*Nbit �� bitlen/num_eye ���� �籸���� ���
y = y';

Ttime = 0:ts:num_eye*Tb-ts;
figure
for ii = 2:bitlen/2  % bit ���� �籸���� ����� �� �ึ�� �׸����ν� Eye Diagram ���°� �Ǵ� ����
    if nargin == 4 && Flag == 1
        stairs(Ttime, y(ii,:)); hold on;
    else
        plot(Ttime, y(ii,:)); hold on;
    end
end
