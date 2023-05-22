%----------------------------------------------------------------
%-----------------------configurations---------------------------
%----------------------------------------------------------------
Carrier_Frequency = 48000;
delta_omega=0;
%{
           *****observasion**** 
by changing the omega we notice that the signel lose information proportional to the change in omega
%}
Modulation_Sampling_Rate=97000;

time_plot_no=2;
frequency_plot_no=2;

modulation_cutoff_freq = 3400; % Cutoff frequency for the low-pass filter
LPF_modulation_order = 2; % Filter order

%------------------------------------------------------------------
%-----------------------READ THE AUDIO FILE------------------------
%------------------------------------------------------------------
filename = 'Filtered_Recording.wav';  
[Signal_Values, Sample_Frequency] = audioread(filename);

Signal_Values_H_SAMPLE=resample(Signal_Values,Modulation_Sampling_Rate,Sample_Frequency);

%------------------------------------------------------------------
%-----------------------DSB-SC MODULATION--------------------------
%------------------------------------------------------------------
t = (0:length(Signal_Values_H_SAMPLE)-1)/Modulation_Sampling_Rate; % Time vector
carrier = cos(2*pi*Carrier_Frequency*t);                  % Local carrier signal
mod_signal_DSB_SC = Signal_Values_H_SAMPLE .* carrier';            
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(mod_signal_DSB_SC)-1)/Modulation_Sampling_Rate;
figure(1);
subplot(time_plot_no,2,1);
plot(t, mod_signal_DSB_SC);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated(DSB-SC)Signal in Time Domain');
figure(2)
% Plot the modulated signal in the frequency domain
N = length(mod_signal_DSB_SC);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(mod_signal_DSB_SC)));
subplot(frequency_plot_no,2,1);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated(DSB-SC)Signal Spectrum');
%------------------------------------------------------------------
%-----------------------DSB-SC De-MODULATION--------------------------
%------------------------------------------------------------------
t = (0:length(mod_signal_DSB_SC)-1)/Modulation_Sampling_Rate;   % Time vector
carrier = cos(2*pi*(Carrier_Frequency+delta_omega)*t);                        % Local carrier signal
recovered_signal_DSB_SC = mod_signal_DSB_SC .* carrier';        % Coherent demodulation

% Design the low-pass filter
LPF = designfilt('lowpassfir', 'FilterOrder', LPF_modulation_order, 'CutoffFrequency', modulation_cutoff_freq, 'SampleRate', Modulation_Sampling_Rate);

% Apply the filter to the demodulated signal
DSB_SC_RECOVERED = filter(LPF, recovered_signal_DSB_SC);
DSB_SC_RECOVERED_L_SAMPLE=resample(DSB_SC_RECOVERED,Sampling_Rate,Modulation_Sampling_Rate);
% Optionally amplify the baseband audio signal if needed
% baseband_audio = baseband_audio * amplification_factor;
disp('demodulation DSB-SC signal playing now....');
% Play the recovered audio signal
sound(DSB_SC_RECOVERED_L_SAMPLE,Sampling_Rate);
pause(length(DSB_SC_RECOVERED_L_SAMPLE)/Sampling_Rate);

%----------------------------------------------------------------
%-------------------PLOT De-MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
figure(1);
t = (0:length(DSB_SC_RECOVERED_L_SAMPLE)-1)/Sampling_Rate;
subplot(time_plot_no,2,2);
plot(t, DSB_SC_RECOVERED_L_SAMPLE);
xlabel('Time (s)');
ylabel('Amplitude');
title('DeModulated(DSB-SC)Signal in Time Domain');

figure(2);
% Plot the modulated signal in the frequency domain
N = length(DSB_SC_RECOVERED_L_SAMPLE);
f = (-N/2:N/2-1)*Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(DSB_SC_RECOVERED_L_SAMPLE)));

subplot(frequency_plot_no,2,2);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('DeModulated(DSB-SC)Signal Spectrum');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------------------------------------------------
%-----------------------SSB-SC MODULATION--------------------------
%------------------------------------------------------------------
t = (0:length(Signal_Values_H_SAMPLE)-1)/Modulation_Sampling_Rate; % Time vector
carrier_sin = sin(2*pi*Carrier_Frequency*t);
carrier_cos = cos(2*pi*Carrier_Frequency*t);                  % Local carrier signal
signal_values_hilbert = hilbert(Signal_Values_H_SAMPLE);
mod_signal_SSB = real((Signal_Values_H_SAMPLE .* carrier_cos')+(signal_values_hilbert .*carrier_sin'));  % Coherent demodulation
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(mod_signal_SSB)-1)/Modulation_Sampling_Rate;
figure(1);
subplot(time_plot_no,2,3);
plot(t, mod_signal_SSB);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated(SSB-SC)Signal in Time Domain');
figure(2);
% Plot the modulated signal in the frequency domain
N = length(mod_signal_SSB);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(mod_signal_SSB)));

subplot(frequency_plot_no,2,3);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated(SSB-SC)Signal Spectrum');

%------------------------------------------------------------------
%-----------------------SSB-SC De-MODULATION--------------------------
%------------------------------------------------------------------
t = (0:length(mod_signal_SSB)-1)/Modulation_Sampling_Rate; % Time vector
carrier = cos(2*pi*(Carrier_Frequency+delta_omega)*t); % Local carrier signal
recovered_signal_SSB = mod_signal_SSB .* carrier'; % Coherent demodulation

modulation_cutoff_freq = 5000; % Cutoff frequency for the low-pass filter
LPF_modulation_order = 100; % Filter order

% Design the low-pass filter
LPF = designfilt('lowpassfir', 'FilterOrder', LPF_modulation_order, 'CutoffFrequency', modulation_cutoff_freq, 'SampleRate', Modulation_Sampling_Rate);

% Apply the filter to the demodulated signal
SSB_SC_RECOVERED = filter(LPF, recovered_signal_SSB);
SSB_SC_RECOVERED_L_SAMPLE=resample(SSB_SC_RECOVERED,Sampling_Rate,Modulation_Sampling_Rate);
% Optionally amplify the baseband audio signal if needed
% baseband_audio = baseband_audio * amplification_factor;
disp('demodulation SSB signal playing now....');
% Play the recovered audio signal
sound(SSB_SC_RECOVERED_L_SAMPLE,Sample_Frequency);
pause(length(SSB_SC_RECOVERED_L_SAMPLE)/Sampling_Rate);
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(SSB_SC_RECOVERED_L_SAMPLE)-1)/Sampling_Rate;
figure(1);
subplot(time_plot_no,2,4);
plot(t, SSB_SC_RECOVERED_L_SAMPLE);
xlabel('Time (s)');
ylabel('Amplitude');
title('DeModulated(SSB-SC)Signal in Time Domain');
figure(2);
% Plot the modulated signal in the frequency domain
N = length(SSB_SC_RECOVERED_L_SAMPLE);
f = (-N/2:N/2-1)*Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(SSB_SC_RECOVERED_L_SAMPLE)));

subplot(frequency_plot_no,2,4);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('DeModulated(SSB-SC)Signal Spectrum');