%------------------------------------------------------------------
%-----------------------READ THE AUDIO FILE beta =3----------------
%------------------------------------------------------------------
filename = 'fm_mod_Recording_beta_3.wav';  
[Signal_Values, Sample_Frequency] = audioread(filename);

%------------------------------------------------------------------
%---------addition of Gaussian noise to the FM signal--------------
%------------------------------------------------------------------
noise_level_1 = 0.1;         % First noise level 
noise_level_2 = 0.5;         % Second noise level 

noisy_signal_1 = Signal_Values + noise_level_1 * randn(size(Signal_Values));
noisy_signal_2 = Signal_Values + noise_level_2 * randn(size(Signal_Values));

signal_power = rms(Signal_Values)^2;

noise_power_1 = rms(noise_level_1 * randn(size(Signal_Values)))^2;
SNR_1 = 10*log10(signal_power / noise_power_1);

noise_power_2 = rms(noise_level_2 * randn(size(Signal_Values)))^2;
SNR_2 = 10*log10(signal_power / noise_power_2);

disp('SNR for noise level 1 beta=3 : ');
disp(SNR_1);
disp('SNR for noise level 2 beta=3 : ');
disp(SNR_2);
%------------------------------------------------------------------
%-----------------------READ THE AUDIO FILE beta =5----------------
%------------------------------------------------------------------
filename = 'fm_mod_Recording_beta_5.wav';  % Replace with your audio file name and path
[Signal_Values, Sample_Frequency] = audioread(filename);

%------------------------------------------------------------------
%---------addition of Gaussian noise to the FM signal--------------
%------------------------------------------------------------------
noise_level_1 = 0.1;         % First noise level 
noise_level_2 = 0.5;         % Second noise level 

noisy_signal_1 = Signal_Values + noise_level_1 * randn(size(Signal_Values));
noisy_signal_2 = Signal_Values + noise_level_2 * randn(size(Signal_Values));

signal_power = rms(Signal_Values)^2;

noise_power_1 = rms(noise_level_1 * randn(size(Signal_Values)))^2;
SNR_1 = 10*log10(signal_power / noise_power_1);

noise_power_2 = rms(noise_level_2 * randn(size(Signal_Values)))^2;
SNR_2 = 10*log10(signal_power / noise_power_2);

disp('SNR for noise level 1 beta=5 : ');
disp(SNR_1);
disp('SNR for noise level 2 beta=5 : ');
disp(SNR_2);
%{
-------------------------observation-----------------------------
Higher noise levels will generally result in lower SNR and degraded signal quality.
%}