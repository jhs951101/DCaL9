clear all; close all;

Rb = 1000;      fs = 40*Rb;

bitlen = 20;
bit = randi([0,1],1,bitlen);

name = 'manchester'  % polar_nrz, unipolar_nrz, bipolar_rz, manchester

[x, time] = Function_Linecode_Gen(bit, name, Rb, fs);
% -------------------------------------------------------------------------
% Effects of Channel Bandwidth;
% -------------------------------------------------------------------------
channel_gain = 1;
noise_power = 0;
f_cutoff = [5000, 2500, 800, 500];

y1 = Function_Channel_Filter(x, channel_gain, noise_power, f_cutoff(1), fs);
y2 = Function_Channel_Filter(x, channel_gain, noise_power, f_cutoff(2), fs);
y3 = Function_Channel_Filter(x, channel_gain, noise_power, f_cutoff(3), fs);
y4 = Function_Channel_Filter(x, channel_gain, noise_power, f_cutoff(4), fs);
% -------------------------------------------------------------------------
AXIS_TIME1 = [-inf inf -2 2];

figure
subplot(211), stairs(time, x); grid on; axis(AXIS_TIME1);
xlabel('Time [sec]'); ylabel('Signal waveform');
title(['f_{cutoff}/f_s = ', num2str(f_cutoff(1)),'/',num2str(fs)]);
subplot(212), plot(time, y1); grid on; axis(AXIS_TIME1);
xlabel('Time [sec]'); ylabel('Signal waveform');

figure
subplot(211), stairs(time, x); grid on; axis(AXIS_TIME1);
xlabel('Time [sec]'); ylabel('Signal waveform');
title(['f_{cutoff}/f_s = ', num2str(f_cutoff(2)),'/',num2str(fs)]);
subplot(212), plot(time, y2); grid on; axis(AXIS_TIME1);
xlabel('Time [sec]'); ylabel('Signal waveform');

figure
subplot(211), stairs(time, x); grid on; axis(AXIS_TIME1);
xlabel('Time [sec]'); ylabel('Signal waveform');
title(['f_{cutoff}/f_s = ', num2str(f_cutoff(3)),'/',num2str(fs)]);
subplot(212), plot(time, y3); grid on; axis(AXIS_TIME1);
xlabel('Time [sec]'); ylabel('Signal waveform');

figure
subplot(211), stairs(time, x); grid on; axis(AXIS_TIME1);
xlabel('Time [sec]'); ylabel('Signal waveform');
title(['f_{cutoff}/f_s = ', num2str(f_cutoff(4)),'/',num2str(fs)]);
subplot(212), plot(time, y4); grid on; axis(AXIS_TIME1);
xlabel('Time [sec]'); ylabel('Signal waveform');
% -------------------------------------------------------------------------
% Effects of Channel Noise;
% -------------------------------------------------------------------------
pause;

noise_power = [0.01, 0.1, 0.5, 1.0];
f_cutoff = 5000;

y1 = Function_Channel_Filter(x, channel_gain, noise_power(1), f_cutoff, fs);
y2 = Function_Channel_Filter(x, channel_gain, noise_power(2), f_cutoff, fs);
y3 = Function_Channel_Filter(x, channel_gain, noise_power(3), f_cutoff, fs);
y4 = Function_Channel_Filter(x, channel_gain, noise_power(4), f_cutoff, fs);
% -------------------------------------------------------------------------
AXIS_TIME2 = [-inf inf -2.5 2.5];
figure
subplot(211), stairs(time, x); grid on; axis(AXIS_TIME2);
xlabel('Time [sec]'); ylabel('Signal waveform');
title(['noise power = ',num2str(noise_power(1))]);
subplot(212), plot(time, y1); grid on; axis(AXIS_TIME2);
xlabel('Time [sec]'); ylabel('Signal waveform');

figure
subplot(211), stairs(time, x); grid on; axis(AXIS_TIME2);
xlabel('Time [sec]'); ylabel('Signal waveform');
title(['noise power = ',num2str(noise_power(2))]);
subplot(212), plot(time, y2); grid on; axis(AXIS_TIME2);
xlabel('Time [sec]'); ylabel('Signal waveform');

figure
subplot(211), stairs(time, x); grid on; axis(AXIS_TIME2);
xlabel('Time [sec]'); ylabel('Signal waveform');
title(['noise power = ',num2str(noise_power(3))]);
subplot(212), plot(time, y3); grid on; axis(AXIS_TIME2);
xlabel('Time [sec]'); ylabel('Signal waveform');

figure
subplot(211), stairs(time, x); grid on; axis(AXIS_TIME2);
xlabel('Time [sec]'); ylabel('Signal waveform');
title(['noise power = ',num2str(noise_power(4))]);
subplot(212), plot(time, y4); grid on; axis(AXIS_TIME2);
xlabel('Time [sec]'); ylabel('Signal waveform');
% -------------------------------------------------------------------------
% PSD of channel filter output;
% -------------------------------------------------------------------------
bitlen = 2000;
bit = randi([0,1], 1, bitlen);

x = Function_Linecode_Gen(bit, name, Rb, fs);

[Sx, f] = Function_PSD_dB(x, fs);  f = f./1000;    % For Hz -> KHz

f_cutoff = 5000;
y1 = Function_Channel_Filter(x, channel_gain, noise_power(1), f_cutoff, fs);
y2 = Function_Channel_Filter(x, channel_gain, noise_power(2), f_cutoff, fs);
y3 = Function_Channel_Filter(x, channel_gain, noise_power(3), f_cutoff, fs);
y4 = Function_Channel_Filter(x, channel_gain, noise_power(4), f_cutoff, fs);

[Sy1, f1] = Function_PSD_dB(y1, fs);    f1 = f1./1000;  % For Hz -> KHz
[Sy2, f2] = Function_PSD_dB(y2, fs);    f2 = f2./1000;  % For Hz -> KHz
[Sy3, f3] = Function_PSD_dB(y3, fs);    f3 = f3./1000;  % For Hz -> KHz
[Sy4, f4] = Function_PSD_dB(y4, fs);    f4 = f4./1000;  % For Hz -> KHz

% -------------------------------------------------------------------------
AXIS_FREQ = [0, 10, -70 -10];

figure
plot(f, Sx);
grid on; axis(AXIS_FREQ); xlabel('Frequency [KHz]'); ylabel('Power Spectral [dB]');
title('PSD of line code waveform');

str1 = ['Channel Noise = ', num2str(noise_power(1))];
str2 = ['Channel Noise = ', num2str(noise_power(2))];
str3 = ['Channel Noise = ', num2str(noise_power(3))];
str4 = ['Channel Noise = ', num2str(noise_power(4))];

figure
plot(f1, Sy1, 'k'); hold on;
plot(f2, Sy2, 'm'); hold on;
plot(f3, Sy3, 'b'); hold on;
plot(f4, Sy4, 'r'); hold on;
grid on; axis(AXIS_FREQ); xlabel('Frequency [KHz]'); ylabel('Power Spectral [dB]');
title('PSD of line code waveform with channel noise');
legend(str1, str2, str3, str4);




