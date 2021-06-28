clear all; close all;

Rb = 1000;  fs = 40*Rb;
Tb = 1/Rb;  ts = 1/fs;

bitlen = 400;
bit = randi([0,1], 1, bitlen);

name = 'manchester'  % polar_nrz, unipolar_nrz, bipolar_rz, manchester

[x, time] = Function_Linecode_Gen(bit, name, Rb, fs);
% -------------------------------------------------------------------------

AXIS_EYE = [0, 2*Tb, -2 2];
Function_Eye_Pattern(x, Rb, fs, 1);
grid on; axis(AXIS_EYE);
xlabel('Time [sec]'); title('Eye Diagram');

% -------------------------------------------------------------------------
% Bandlimited filter only;
% -------------------------------------------------------------------------
f_cutoff = [2500, 800, 500];
noise_power = 0;

y1 = Function_Channel_Filter(x, 1, noise_power, f_cutoff(1), fs);
y2 = Function_Channel_Filter(x, 1, noise_power, f_cutoff(2), fs);
y3 = Function_Channel_Filter(x, 1, noise_power, f_cutoff(3), fs);

% -------------------------------------------------------------------------
Function_Eye_Pattern(y1, Rb, fs);
grid on; axis(AXIS_EYE);
xlabel('Time [sec]'); title(['Eye Diagram, f_{cutoff} = ',num2str(f_cutoff(1)),' , noise = ',num2str(noise_power)]);

Function_Eye_Pattern(y2, Rb, fs);
grid on; axis(AXIS_EYE);
xlabel('Time [sec]'); title(['Eye Diagram, f_{cutoff} = ',num2str(f_cutoff(2)),' , noise = ',num2str(noise_power)]);

Function_Eye_Pattern(y3, Rb, fs);
grid on; axis(AXIS_EYE);
xlabel('Time [sec]'); title(['Eye Diagram, f_{cutoff} = ',num2str(f_cutoff(3)),' , noise = ',num2str(noise_power)]);
% -------------------------------------------------------------------------
pause;
% -------------------------------------------------------------------------
% Filter and noise;
% -------------------------------------------------------------------------

bitlen = 100;
bit = randi([0,1], 1, bitlen);

[x, time] = Function_Linecode_Gen(bit, name, Rb, fs);
% -------------------------------------------------------------------------
f_cutoff = 800;
noise_power = [0, 0.1, 0.2];

y1 = Function_Channel_Filter(x, 1, noise_power(1), f_cutoff, fs);
y2 = Function_Channel_Filter(x, 1, noise_power(2), f_cutoff, fs);
y3 = Function_Channel_Filter(x, 1, noise_power(3), f_cutoff, fs);

% -------------------------------------------------------------------------
Function_Eye_Pattern(y1, Rb, fs);
grid on; axis(AXIS_EYE);
xlabel('Time [sec]'); title(['Eye Diagram, f_{cutoff} = ',num2str(f_cutoff),' , noise = ',num2str(noise_power(1))]);

Function_Eye_Pattern(y2, Rb, fs);
grid on; axis(AXIS_EYE);
xlabel('Time [sec]'); title(['Eye Diagram, f_{cutoff} = ',num2str(f_cutoff),' , noise = ',num2str(noise_power(2))]);

Function_Eye_Pattern(y3, Rb, fs);
grid on; axis(AXIS_EYE);
xlabel('Time [sec]'); title(['Eye Diagram, f_{cutoff} = ',num2str(f_cutoff),' , noise = ',num2str(noise_power(3))]);


