%----------------------------------------------------------------
%-----------------------configurations---------------------------
%----------------------------------------------------------------
Carrier_Frequency = 48000;     
Modulation_Sampling_Rate=97000;

deviation_ratio_1=3;
deviation_ratio_2=5;

time_plot_no=3;
frequency_plot_no=3;
%------------------------------------------------------------------
%-----------------------READ THE AUDIO FILE------------------------
%------------------------------------------------------------------
filename = 'Filtered_Recording.wav';  
[Signal_Values, Sample_Frequency] = audioread(filename);

Signal_Values_H_SAMPLE=resample(Signal_Values,Modulation_Sampling_Rate,Sample_Frequency);
%------------------------------------------------------------------
%-----------------------FM MODULATION beta 1------------------------------
%------------------------------------------------------------------
%first way
%{
t_fm_mod = (0:length(Signal_Values_H_SAMPLE)-1)/Modulation_Sampling_Rate;
t_fm_mod_reverse=t_fm_mod'
FM_modulated_signal=cos(2*pi*(Carrier_Frequency+deviation_ratio_1*Signal_Values_H_SAMPLE).*t_fm_mod_reverse);
%}
%second way
FM_modulated_signal=fmmod(Signal_Values_H_SAMPLE,Carrier_Frequency,Modulation_Sampling_Rate,deviation_ratio_1);
%save record
audiowrite('fm_mod_Recording_beta_3.wav', FM_modulated_signal,Modulation_Sampling_Rate);
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(FM_modulated_signal)-1)/Modulation_Sampling_Rate;
figure(1);
subplot(time_plot_no,2,1);
plot(t, FM_modulated_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated FM beta(3) Signal in Time Domain');
figure(2);
% Plot the modulated signal in the frequency domain
N = length(FM_modulated_signal);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(FM_modulated_signal)));
subplot(frequency_plot_no,2,1);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated FM beta(3) Signal Spectrum');
%------------------------------------------------------------------
%-----------------------FM DeMODULATION----------------------------
%------------------------------------------------------------------
demodulate_fm_signal=fmdemod(FM_modulated_signal, Carrier_Frequency,Modulation_Sampling_Rate,deviation_ratio_1);
demodulate_fm_signal_L_SAMPLE=resample(demodulate_fm_signal,Sample_Frequency,Modulation_Sampling_Rate);
disp('modulation FM beta(3) signal playing now....');
sound(demodulate_fm_signal_L_SAMPLE,Sample_Frequency);
pause(length(demodulate_fm_signal_L_SAMPLE)/Sample_Frequency);
%----------------------------------------------------------------
%-------------------PLOT DEMODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(demodulate_fm_signal_L_SAMPLE)-1)/Sample_Frequency;
figure(1);
subplot(time_plot_no,2,2);
plot(t, demodulate_fm_signal_L_SAMPLE);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated FM beta(3) Signal in Time Domain');
figure(2);
% Plot the modulated signal in the frequency domain
N = length(demodulate_fm_signal_L_SAMPLE);
f = (-N/2:N/2-1)*Sample_Frequency/N;
mod_signal_fft = abs(fftshift(fft(demodulate_fm_signal_L_SAMPLE)));
subplot(frequency_plot_no,2,2);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated FM beta(3) Signal Spectrum');
%------------------------------------------------------------------
%-----------------------FM MODULATION beta 2-----------------------
%------------------------------------------------------------------
%first way
%{
t_fm_mod = (0:length(Signal_Values_H_SAMPLE)-1)/Modulation_Sampling_Rate;
t_fm_mod_reverse=t_fm_mod'
FM_modulated_signal=cos(2*pi*(Carrier_Frequency+deviation_ratio_2*Signal_Values_H_SAMPLE).*t_fm_mod_reverse);
%}
%second way
FM_modulated_signal=fmmod(Signal_Values_H_SAMPLE,Carrier_Frequency,Modulation_Sampling_Rate,deviation_ratio_2);
%save record
audiowrite('fm_mod_Recording_beta_5.wav', FM_modulated_signal,Modulation_Sampling_Rate);
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(FM_modulated_signal)-1)/Modulation_Sampling_Rate;
figure(1);
subplot(time_plot_no,2,3);
plot(t, FM_modulated_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated FM beta(5) Signal in Time Domain');
figure(2);
% Plot the modulated signal in the frequency domain
N = length(FM_modulated_signal);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(FM_modulated_signal)));
subplot(frequency_plot_no,2,3);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated FM beta(5) Signal Spectrum');
%------------------------------------------------------------------
%-----------------------FM DeMODULATION----------------------------
%------------------------------------------------------------------
demodulate_fm_signal=fmdemod(FM_modulated_signal, Carrier_Frequency,Modulation_Sampling_Rate,deviation_ratio_2);
demodulate_fm_signal_L_SAMPLE=resample(demodulate_fm_signal,Sample_Frequency,Modulation_Sampling_Rate);
disp('modulation FM beta(5) signal playing now....');
sound(demodulate_fm_signal_L_SAMPLE,Sample_Frequency);
pause(length(demodulate_fm_signal_L_SAMPLE)/Sample_Frequency);
%----------------------------------------------------------------
%-------------------PLOT DEMODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(demodulate_fm_signal_L_SAMPLE)-1)/Sample_Frequency;
figure(1);
subplot(time_plot_no,2,4);
plot(t, demodulate_fm_signal_L_SAMPLE);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated FM beta(5) Signal in Time Domain');
figure(2);
% Plot the modulated signal in the frequency domain
N = length(demodulate_fm_signal_L_SAMPLE);
f = (-N/2:N/2-1)*Sample_Frequency/N;
mod_signal_fft = abs(fftshift(fft(demodulate_fm_signal_L_SAMPLE)));
subplot(frequency_plot_no,2,4);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated FM beta(5) Signal Spectrum');
%------------------------------------------------------------------
%-----------------------FM TONE MODULATION------------------------------
%------------------------------------------------------------------
duration = 1.0;  % Duration of the FM signal (seconds)
frequency = 3000;  % Frequency of the sinusoidal tone (Hz)
  % Frequency deviation (Hz)
%fisrt way

t = 0:1/Modulation_Sampling_Rate:duration;  % Time vector

audio_signal = sin(2*pi*frequency*t);       % Sinusoidal tone
%{
FM_MODULATION_TONE = cos(2*pi*(Carrier_Frequency+deviation*audio_signal).*t);  % FM modulation
%}
%second way
FM_MODULATION_TONE=fmmod(audio_signal,Carrier_Frequency,Modulation_Sampling_Rate,deviation_ratio_2);

%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(FM_MODULATION_TONE)-1)/Modulation_Sampling_Rate;
figure(1);
subplot(time_plot_no,2,5);
plot(t, FM_MODULATION_TONE);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated TONE-FM Signal in Time Domain');
figure(2);
subplot(frequency_plot_no,2,5);
% Plot the modulated signal in the frequency domain
N = length(FM_MODULATION_TONE);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(FM_MODULATION_TONE)));
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated TONE-FM Signal Spectrum');
%------------------------------------------------------------------
%-----------------------FM DeMODULATION----------------------------
%------------------------------------------------------------------
%fisrt way
demodulate_TONE_fm_signal=fmdemod(FM_MODULATION_TONE, Carrier_Frequency,Modulation_Sampling_Rate,deviation_ratio_2);
%second Way
%demodulate_TONE_fm_signal=demod(FM_MODULATION_TONE,Carrier_Frequency,Modulation_Sampling_Rate,'fm'); 
demodulate_TONE_fm_signal_L_SAMPLE=resample(demodulate_TONE_fm_signal,Sample_Frequency,Modulation_Sampling_Rate);
%----------------------------------------------------------------
%-------------------PLOT DEMODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(demodulate_TONE_fm_signal_L_SAMPLE)-1)/Sample_Frequency;
figure(1);
subplot(time_plot_no,2,6);
plot(t, demodulate_TONE_fm_signal_L_SAMPLE);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated TONE-FM Signal in Time Domain');

figure(2);
% Plot the modulated signal in the frequency domain
N = length(demodulate_TONE_fm_signal_L_SAMPLE);
f = (-N/2:N/2-1)*Sample_Frequency/N;
mod_signal_fft = abs(fftshift(fft(demodulate_TONE_fm_signal_L_SAMPLE)));
subplot(frequency_plot_no,2,6);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated TONE-FM Signal Spectrum');