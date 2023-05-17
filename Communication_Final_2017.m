%----------------------------------------------------------------
%-----------------------configurations---------------------------
%----------------------------------------------------------------
Sampling_Rate = 97000; % sampling frequency (Hz)
Record_Sensitivity = 16; % number of bits per sample
Record_Time=9;

Carrier_Frequency = 48000;     
Modulation_Sampling_Rate=97000;

modulation_cutoff_freq = 5000; % Cutoff frequency for the low-pass filter
LPF_modulation_order = 100; % Filter order

%----------------------------------------------------------------
%-----------------------AUDIO-RECORDING--------------------------
%----------------------------------------------------------------
% create audiorecorder object
record_object = audiorecorder(Sampling_Rate, Record_Sensitivity, 1);
%Start Recording
disp('Start speaking.');
recordblocking(record_object, Record_Time);
disp('End of recording.');
% get recorded data
Signal_values = getaudiodata(record_object);
%save record
audiowrite('myRecording.wav', Signal_values,Sampling_Rate);

%----------------------------------------------------------------
%----------------CALCULATE POWER AND DISPALY IT------------------
%----------------------------------------------------------------
N = length(Signal_values);
Recorded_signal_Power = 1/N * sum(abs(Signal_values).^2);
disp(Recorded_signal_Power);

%----------------------------------------------------------------
%-----------------------REPLAY-RECORDING-------------------------
%----------------------------------------------------------------
%play the record
sound(Signal_values,Sampling_Rate);
pause(length(Signal_values)/Sampling_Rate);

%----------------------------------------------------------------
%-----------------------PLOT RECORD------------------------------
%----------------------------------------------------------------
%plot the recorded signal in TIME domain
subplot(3,1,1);
Time_axis = (0:length(Signal_values)-1)/Sampling_Rate;
plot(Time_axis,Signal_values),title('Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
%plot the signal in FREQUENCY domain
N = length(Signal_values);
f = (-N/2:N/2-1)*Sampling_Rate/N;
signal_fft = abs(fftshift(fft(Signal_values)));

subplot(3,1,2);
plot(f, signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Record Signal Spectrum');
