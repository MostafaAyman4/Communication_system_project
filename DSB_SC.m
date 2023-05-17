
%------------------------------------------------------------------
%-----------------------DSB-SC MODULATION--------------------------
%------------------------------------------------------------------
t = (0:length(Signal_values)-1)/Modulation_Sampling_Rate; % Time vector
carrier = cos(2*pi*Carrier_Frequency*t);                  % Local carrier signal
mod_signal_DSB_SC = Signal_values .* carrier';            % Coherent demodulation
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(mod_signal_DSB_SC)-1)/Modulation_Sampling_Rate;
figure;
subplot(2,1,1);
plot(t, mod_signal_DSB_SC);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated(DSB-SC)Signal in Time Domain');

% Plot the modulated signal in the frequency domain
N = length(mod_signal_DSB_SC);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(mod_signal_DSB_SC)));

subplot(2,1,2);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated(DSB-SC)Signal Spectrum');
%------------------------------------------------------------------
%-----------------------DSB-SC De-MODULATION--------------------------
%------------------------------------------------------------------
t = (0:length(mod_signal_DSB_SC)-1)/Modulation_Sampling_Rate; % Time vector
carrier = cos(2*pi*Carrier_Frequency*t); % Local carrier signal
recovered_signal_DSB_SC = mod_signal_DSB_SC .* carrier'; % Coherent demodulation

modulation_cutoff_freq = 5000; % Cutoff frequency for the low-pass filter
LPF_modulation_order = 100; % Filter order

% Design the low-pass filter
LPF = designfilt('lowpassfir', 'FilterOrder', LPF_modulation_order, 'CutoffFrequency', modulation_cutoff_freq, 'SampleRate', Modulation_Sampling_Rate);

% Apply the filter to the demodulated signal
DSB_SC_RECOVERED = filter(LPF, recovered_signal_DSB_SC);

% Optionally amplify the baseband audio signal if needed
% baseband_audio = baseband_audio * amplification_factor;
disp('demodulation DSB-SC signal playing now....');
% Play the recovered audio signal
sound(DSB_SC_RECOVERED, Modulation_Sampling_Rate);

%----------------------------------------------------------------
%-------------------PLOT De-MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(DSB_SC_RECOVERED)-1)/Modulation_Sampling_Rate;
figure;
subplot(2,1,1);
plot(t, DSB_SC_RECOVERED);
xlabel('Time (s)');
ylabel('Amplitude');
title('DeModulated(DSB-SC)Signal in Time Domain');

% Plot the modulated signal in the frequency domain
N = length(DSB_SC_RECOVERED);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(DSB_SC_RECOVERED)));

subplot(2,1,2);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('DeModulated(DSB-SC)Signal Spectrum');