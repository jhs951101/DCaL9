function [x, time] = Function_Linecode_Gen(bit, code_name, Rb, fs)

Tb = 1/Rb; ts = 1/fs;  % Tb: 비트 주기, ts: 시간 영역에서의 간격
Nbit = fs/Rb;  % Nbit: 비트 하나 당 길이

bitlen = length(bit);  % bitlen: 비트 전체 길이

bitp = bit;  % bit: 0 또는 1의 값들로 이루어진 집합체
bitp(bitp==0) = -1;  % bitp: 1 또는 -1의 값들로 이루어진 집합체
bitb = zeros(1, bitlen);  % bitb: 0 또는 1 또는 -1의 값들로 이루어진 집합체
bflag = 1;  % bflag: 값을 toogle 시켜주기 위한 변수
for ii = 1:bitlen
    if bitp(ii) == 0
        bitb(ii) = bitp(ii);
    elseif bitp(ii) == 1
        bitb(ii) = bflag;
        bflag = -bflag;  % bflag에 -1을 곱해줌으로써 toogle 시킬 수 있음
    end
end
% -------------------------------------------------------------------------
time = 0:ts:(bitlen*Tb)-ts;  % time: 시간축을 의미하는 변수

pulse_nrz = ones(1, Nbit);
% pulse_nrz: 0으로 return하지 않으므로 모든 값이 1로만 세팅된 집합체
pulse_rz = [ones(1, Nbit/2), zeros(1, Nbit/2)];
% pulse_rz: 0으로 return 하므로 앞부분은 1로, 뒷부분은 0으로 세팅된 집합체
pulse_man = [ones(1,Nbit/2), -ones(1,Nbit/2)];
% pulse_man: 앞부분은 1로, 뒷부분은 -1로 세팅된 집합체

% -------------------------------------------------------------------------
if strcmp(code_name, 'unipolar_nrz')
    x = bit'*pulse_nrz;  % unipolar_nrz: 0과 1을 모두 그대로 둠
elseif strcmp(code_name, 'polar_nrz')
    x = bitp'*pulse_nrz;  % polar_nrz: 1은 그대로 두고, 0은 -1로 떨어뜨림
elseif strcmp(code_name, 'bipolar_nrz')
    x = bitb'*pulse_nrz;  % bipolar_nrz: 0은 그대로 두고, 1에서는 toogle이 발생함
elseif strcmp(code_name, 'unipolar_rz')
    x = bit'*pulse_rz;  % unipolar_rz: 'unipolar_nrz' 하고 유사하나, 1에서는 0으로 되돌아옴
elseif strcmp(code_name, 'polar_rz')
    x = bitp'*pulse_rz;  % polar_rz: 'polar_nrz' 하고 유사하나, 1이든 -1이든 0으로 되돌아옴
elseif strcmp(code_name, 'bipolar_rz')
    x = bitb'*pulse_rz;  % bipolar_rz: 'bipolar_nrz' 하고 유사하나, 1에서는 toogle이 발생한 뒤 0으로 되돌아옴
elseif strcmp(code_name, 'manchester')
    x = bitp'*pulse_man;  % manchester: 1에서는 1 -> -1 으로 중간에 바뀌고, 0에서는 -1 -> 1 으로 바뀜
end
% -------------------------------------------------------------------------
x = x';     x = x(:)';