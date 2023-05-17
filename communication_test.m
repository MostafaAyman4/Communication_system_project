% Load or generate the AM DSB-LC signal
fs = 10000; % Sampling frequency
t = 0:1/fs:1; % Time vector
fc = 1000; % Carrier frequency
fm = 100; % Message frequency
Ac = 1; % Carrier amplitude
Am = 0.5; % Message amplitude
m = Am * cos(2*pi*fm*t); % Message signal
s = (1 + m) .* Ac .* cos(2*pi*fc*t); % AM DSB-LC signal

% Demodulation using envelope detector
cutoff_freq = 200; % Cutoff frequency for the low-pass filter
order = 6; % Filter order

% Design the low-pass filter
lpf = designfilt('lowpassfir', 'FilterOrder', order, 'CutoffFrequency', cutoff_freq, 'SampleRate', fs);

% Apply the filter to the input signal
filtered_signal = filter(lpf, s);

% Rectify the filtered signal to extract the envelope
envelope = abs(filtered_signal);

% Plotting the results
subplot(2,1,1);
plot(t, s);
xlabel('Time');
ylabel('Amplitude');
title('AM DSB-LC Signal');

subplot(2,1,2);
plot(t, envelope);
xlabel('Time');
ylabel('Amplitude');
title('Demodulated Envelope Signal');

