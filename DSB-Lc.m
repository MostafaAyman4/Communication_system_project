%------------------------------------------------------------------
%-----------------------DSB-LC MODULATION--------------------------
%------------------------------------------------------------------
Carrier_Frequency = 48000;     
Modulation_Index = 1;    
Modulation_Sampling_Rate=97000;
%mod_signal_DSB_LC = modulate(Signal_values,Carrier_Frequency , Modulation_Sampling_Rate, 'amdsb-tc', Modulation_Index);
t = (0:length(Signal_values)-1)/Modulation_Sampling_Rate; % Time vector
carrier = cos(2*pi*Carrier_Frequency*t);                  % Local carrier signal
mod_signal_DSB_LC = (1+Modulation_Index.*Signal_values) .* carrier';            % Coherent demodulation
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(mod_signal_DSB_LC)-1)/Modulation_Sampling_Rate;
figure;
subplot(2,1,1);
plot(t, mod_signal_DSB_LC);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated (DSB-LC)Signal in Time Domain');

% Plot the modulated signal in the frequency domain
N = length(mod_signal_DSB_LC);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(mod_signal_DSB_LC)));

subplot(2,1,2);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated (DSB-LC)Signal Spectrum');
%------------------------------------------------------------------
%-----------------------DSB-LC DeMODULATION--------------------------
%------------------------------------------------------------------
% Demodulation using envelope detector
cutoff_freq = 4000; % Cutoff frequency for the low-pass filter
order = 2; % Filter order

% Design the low-pass filter
lpf = designfilt('lowpassfir', 'FilterOrder', order, 'CutoffFrequency', cutoff_freq, 'SampleRate', Sampling_Rate);

% Apply the filter to the input signal
filtered_signal = filter(lpf,mod_signal_DSB_LC );

% Rectify the filtered signal to extract the envelope
envelope = abs(filtered_signal);
figure;
plot(t, envelope);
xlabel('Time');
ylabel('Amplitude');
title('Demodulated Envelope Signal');
disp('demodulation DSB-LC signal playing now....');
% Play the recovered audio signal
sound(envelope, Modulation_Sampling_Rate);