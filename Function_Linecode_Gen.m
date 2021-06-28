function [x, time] = Function_Linecode_Gen(bit, code_name, Rb, fs)

Tb = 1/Rb; ts = 1/fs;  % Tb: ��Ʈ �ֱ�, ts: �ð� ���������� ����
Nbit = fs/Rb;  % Nbit: ��Ʈ �ϳ� �� ����

bitlen = length(bit);  % bitlen: ��Ʈ ��ü ����

bitp = bit;  % bit: 0 �Ǵ� 1�� ����� �̷���� ����ü
bitp(bitp==0) = -1;  % bitp: 1 �Ǵ� -1�� ����� �̷���� ����ü
bitb = zeros(1, bitlen);  % bitb: 0 �Ǵ� 1 �Ǵ� -1�� ����� �̷���� ����ü
bflag = 1;  % bflag: ���� toogle �����ֱ� ���� ����
for ii = 1:bitlen
    if bitp(ii) == 0
        bitb(ii) = bitp(ii);
    elseif bitp(ii) == 1
        bitb(ii) = bflag;
        bflag = -bflag;  % bflag�� -1�� ���������ν� toogle ��ų �� ����
    end
end
% -------------------------------------------------------------------------
time = 0:ts:(bitlen*Tb)-ts;  % time: �ð����� �ǹ��ϴ� ����

pulse_nrz = ones(1, Nbit);
% pulse_nrz: 0���� return���� �����Ƿ� ��� ���� 1�θ� ���õ� ����ü
pulse_rz = [ones(1, Nbit/2), zeros(1, Nbit/2)];
% pulse_rz: 0���� return �ϹǷ� �պκ��� 1��, �޺κ��� 0���� ���õ� ����ü
pulse_man = [ones(1,Nbit/2), -ones(1,Nbit/2)];
% pulse_man: �պκ��� 1��, �޺κ��� -1�� ���õ� ����ü

% -------------------------------------------------------------------------
if strcmp(code_name, 'unipolar_nrz')
    x = bit'*pulse_nrz;  % unipolar_nrz: 0�� 1�� ��� �״�� ��
elseif strcmp(code_name, 'polar_nrz')
    x = bitp'*pulse_nrz;  % polar_nrz: 1�� �״�� �ΰ�, 0�� -1�� ����߸�
elseif strcmp(code_name, 'bipolar_nrz')
    x = bitb'*pulse_nrz;  % bipolar_nrz: 0�� �״�� �ΰ�, 1������ toogle�� �߻���
elseif strcmp(code_name, 'unipolar_rz')
    x = bit'*pulse_rz;  % unipolar_rz: 'unipolar_nrz' �ϰ� �����ϳ�, 1������ 0���� �ǵ��ƿ�
elseif strcmp(code_name, 'polar_rz')
    x = bitp'*pulse_rz;  % polar_rz: 'polar_nrz' �ϰ� �����ϳ�, 1�̵� -1�̵� 0���� �ǵ��ƿ�
elseif strcmp(code_name, 'bipolar_rz')
    x = bitb'*pulse_rz;  % bipolar_rz: 'bipolar_nrz' �ϰ� �����ϳ�, 1������ toogle�� �߻��� �� 0���� �ǵ��ƿ�
elseif strcmp(code_name, 'manchester')
    x = bitp'*pulse_man;  % manchester: 1������ 1 -> -1 ���� �߰��� �ٲ��, 0������ -1 -> 1 ���� �ٲ�
end
% -------------------------------------------------------------------------
x = x';     x = x(:)';