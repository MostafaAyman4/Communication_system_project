%------------------------------------------------------------------
%-----------------------SSB-SC MODULATION--------------------------
%------------------------------------------------------------------
t = (0:length(Signal_values)-1)/Modulation_Sampling_Rate; % Time vector
carrier_sin = sin(2*pi*Carrier_Frequency*t);
carrier_cos = cos(2*pi*Carrier_Frequency*t);                  % Local carrier signal
signal_values_hilbert = hilbert(Signal_values);
mod_signal_SSB = real((Signal_values .* carrier_cos')+(signal_values_hilbert .*carrier_sin'));  % Coherent demodulation
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(mod_signal_SSB)-1)/Modulation_Sampling_Rate;
figure;
subplot(2,1,1);
plot(t, mod_signal_SSB);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated(SSB-SC)Signal in Time Domain');

% Plot the modulated signal in the frequency domain
N = length(mod_signal_SSB);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(mod_signal_SSB)));

subplot(2,1,2);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated(SSB-SC)Signal Spectrum');

%------------------------------------------------------------------
%-----------------------SSB-SC De-MODULATION--------------------------
%------------------------------------------------------------------
t = (0:length(mod_signal_SSB)-1)/Modulation_Sampling_Rate; % Time vector
carrier = cos(2*pi*Carrier_Frequency*t); % Local carrier signal
recovered_signal_SSB = mod_signal_SSB .* carrier'; % Coherent demodulation

modulation_cutoff_freq = 5000; % Cutoff frequency for the low-pass filter
LPF_modulation_order = 100; % Filter order

% Design the low-pass filter
LPF = designfilt('lowpassfir', 'FilterOrder', LPF_modulation_order, 'CutoffFrequency', modulation_cutoff_freq, 'SampleRate', Modulation_Sampling_Rate);

% Apply the filter to the demodulated signal
SSB_SC_RECOVERED = filter(LPF, recovered_signal_SSB);

% Optionally amplify the baseband audio signal if needed
% baseband_audio = baseband_audio * amplification_factor;
disp('demodulation SSB signal playing now....');
% Play the recovered audio signal
sound(SSB_SC_RECOVERED, Modulation_Sampling_Rate);

%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(SSB_SC_RECOVERED)-1)/Modulation_Sampling_Rate;
figure;
subplot(2,1,1);
plot(t, SSB_SC_RECOVERED);
xlabel('Time (s)');
ylabel('Amplitude');
title('DeModulated(SSB-SC)Signal in Time Domain');

% Plot the modulated signal in the frequency domain
N = length(SSB_SC_RECOVERED);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(SSB_SC_RECOVERED)));

subplot(2,1,2);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('DeModulated(SSB-SC)Signal Spectrum');

