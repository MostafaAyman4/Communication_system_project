%----------------------------------------------------------------
%-----------------------configurations---------------------------
%----------------------------------------------------------------
Sampling_Rate = 48000; % sampling frequency (Hz)
Record_Sensitivity = 16; % number of bits per sample
Record_Time=8;

Carrier_Frequency = 48000;     
Modulation_Sampling_Rate=97000;

minimum_cutoff_frequency=500;
cutoff_freq = 3400; % Cutoff frequency for the low-pass filter
order = 100; % Filter order
Modulation_Index = 0.8;    

time_plot_no=3;
frequency_plot_no=3;
%----------------------------------------------------------------
%-----------------------AUDIO-RECORDING--------------------------
%----------------------------------------------------------------
% create audiorecorder object
record_object = audiorecorder(Sampling_Rate, Record_Sensitivity, 1);
%Start Recording
disp('Start speaking...');
recordblocking(record_object, Record_Time);
disp('End of recording.');
% get recorded data
Signal_values = getaudiodata(record_object);
%save record
audiowrite('myRecording.wav', Signal_values,Sampling_Rate);
%----------------------------------------------------------------
%----------------CALCULATE POWER AND DISPALY IT------------------
%----------------------------------------------------------------
Recorded_signal_Power_ww=rms(Signal_values)^2;
disp('POWER OF THE RECORDED SIGNAL -->');
disp(Recorded_signal_Power_ww);
%----------------------------------------------------------------
%-----------------------REPLAY-RECORDING-------------------------
%----------------------------------------------------------------
%play the record
disp('PLAYING THE RECORDED SIGNAL...');
sound(Signal_values,Sampling_Rate);
pause(length(Signal_values)/Sampling_Rate);
%----------------------------------------------------------------
%-----------------------PLOT RECORD------------------------------
%----------------------------------------------------------------
%plot the recorded signal in TIME domain
figure(1);
subplot(time_plot_no,2,1);
Time_axis = (0:length(Signal_values)-1)/Sampling_Rate;
plot(Time_axis,Signal_values),title('Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
figure(2);
%plot the signal in FREQUENCY domain
N = length(Signal_values);
f = (-N/2:N/2-1)*Sampling_Rate/N;
signal_fft = abs(fftshift(fft(Signal_values)));

subplot(frequency_plot_no,2,1);
plot(f, signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Record Signal Spectrum');
%----------------------------------------------------------------
%-----------------------LOW PASS FILTER--------------------------
%----------------------------------------------------------------
b = fir1(order, cutoff_freq/(Sampling_Rate/2),'low');
filtered_signal = filter(b, 1, Signal_values);
%save record
audiowrite('Filtered_Recording.wav', filtered_signal,Sampling_Rate);
%----------------------------------------------------------------
%--------------------PLOT THE FILTERED SIGNALR-------------------
%----------------------------------------------------------------
%plot the recorded signal in TIME domain
figure(1);
subplot(time_plot_no,2,2);
Time_axis = (0:length(filtered_signal)-1)/Sampling_Rate;
plot(Time_axis,filtered_signal),title('fILTERED Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
%plot the signal in FREQUENCY domain
figure(2);
N = length(filtered_signal);
f = (-N/2:N/2-1)*Sampling_Rate/N;
Filtered_signal_fft = abs(fftshift(fft(filtered_signal)));

subplot(frequency_plot_no,2,2);
plot(f, Filtered_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Filtered Signal Spectrum');

%----------------------------------------------------------------
%------------------REPLAY-fILTERED RECORDING---------------------
%----------------------------------------------------------------
%play the record
disp('PLAYING THE Filtered SIGNAL...');
sound(filtered_signal,Sampling_Rate);
pause(length(filtered_signal)/Sampling_Rate);

%----------------------------------------------------------------
%---LOW PASS FILTER AT whichthe signal become unintelligible.----
%----------------------------------------------------------------

b = fir1(order, minimum_cutoff_frequency/(Sampling_Rate/2),'low');
minimum_filtered_signal = filter(b, 1, Signal_values);
%----------------------------------------------------------------
%------------------REPLAY-fILTERED RECORDING---------------------
%----------------------------------------------------------------
%play the record
disp('PLAYING THE HARD Filtered SIGNAL...');
sound(minimum_filtered_signal,Sampling_Rate);
pause(length(minimum_filtered_signal)/Sampling_Rate);
%----------------------------------------------------------------
%-----------------------ALPHAPET-AUDIO-RECORDING--------------------------
%----------------------------------------------------------------
% create audiorecorder object
record_object_2 = audiorecorder(Sampling_Rate, Record_Sensitivity, 1);
%Start Recording
disp('Start pronounce the sounds: f, s, b, d, n, and m...');
recordblocking(record_object_2, Record_Time);
disp('End of recording.');
% get recorded data
Signal_values_2 = getaudiodata(record_object_2);
%save record
audiowrite('ALPPHA_Recording.wav', Signal_values_2,Sampling_Rate);
%----------------------------------------------------------------
%-----------------------LOW PASS FILTER--------------------------
%----------------------------------------------------------------
b = fir1(order, cutoff_freq/(Sampling_Rate/2),'low');
filtered_signal_2 = filter(b, 1, Signal_values_2);
%save record
audiowrite('ALPHA_Filtered_Recording.wav', filtered_signal_2,Sampling_Rate);
%----------------------------------------------------------------
%------------------REPLAY-fILTERED RECORDING---------------------
%----------------------------------------------------------------
%play the record
disp('PLAYING THE ALPHA FILTERED SIGNAL...');
sound(filtered_signal_2,Sampling_Rate);
pause(length(filtered_signal_2)/Sampling_Rate);
%----------------------------------------------------------------
%--------------------PLOT THE FILTERED SIGNALR-------------------
%----------------------------------------------------------------
%plot the recorded signal in TIME domain
figure(1);
subplot(time_plot_no,2,3);
Time_axis_2 = (0:length(filtered_signal_2)-1)/Sampling_Rate;
plot(Time_axis_2,filtered_signal_2),title('ALPHA fILTERED Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
%plot the signal in FREQUENCY domain
figure(2);
N_2 = length(filtered_signal_2);
f_2 = (-N/2:N/2-1)*Sampling_Rate/N_2;
Filtered_signal_fft_2 = abs(fftshift(fft(filtered_signal_2)));

subplot(frequency_plot_no,2,3);
plot(f_2, Filtered_signal_fft_2);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('ALPHA Filtered Signal Spectrum');
%----------------------------------------------------------------
%---LOW PASS FILTER AT whichthe signal become unintelligible.----
%----------------------------------------------------------------
minimam_cutoff_frequency=300;
b = fir1(order, minimam_cutoff_frequency/(Sampling_Rate/2),'low');
minimum_filtered_signal_2 = filter(b, 1, Signal_values_2);
%----------------------------------------------------------------
%------------------REPLAY-fILTERED RECORDING---------------------
%----------------------------------------------------------------
%play the record
disp('PLAYING THE HARD ALPHA Filtered SIGNAL...');
sound(minimum_filtered_signal_2,Sampling_Rate);
pause(length(minimum_filtered_signal_2)/Sampling_Rate);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------------------------------------------------------
%-----------------------DSB-LC MODULATION--------------------------
%------------------------------------------------------------------
Signal_values_H_SAMPLE=resample(Signal_values,Modulation_Sampling_Rate,Sampling_Rate);
mod_signal_DSB_LC = modulate(Signal_values_H_SAMPLE,Carrier_Frequency , Modulation_Sampling_Rate, 'amdsb-tc', Modulation_Index);
%{
---------AN OTHER WAY USING EQUATION BUT IT DID NOT WORKWELL-----------
t = (0:length(Signal_values)-1)/Modulation_Sampling_Rate; % Time vector
carrier = cos(2*pi*Carrier_Frequency*t);                  % Local carrier signal
mod_signal_DSB_LC = (1+Modulation_Index.*Signal_values) .* carrier'; 
%}
%----------------------------------------------------------------
%-------------------PLOT MODULATED SIGNAL------------------------
%----------------------------------------------------------------
% Plot the modulated signal in the time domain
t = (0:length(mod_signal_DSB_LC)-1)/Modulation_Sampling_Rate;
figure(1);
subplot(time_plot_no,2,4);
plot(t, mod_signal_DSB_LC);
xlabel('Time (s)');
ylabel('Amplitude');
title('Modulated (DSB-LC)Signal in Time Domain');

% Plot the modulated signal in the frequency domain
N = length(mod_signal_DSB_LC);
f = (-N/2:N/2-1)*Modulation_Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(mod_signal_DSB_LC)));

figure(2);
subplot(frequency_plot_no,2,4);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated (DSB-LC)Signal Spectrum');
%------------------------------------------------------------------
%-----------------------DSB-LC DeMODULATION--------------------------
%------------------------------------------------------------------

demodulated_DSB_LC=demod(mod_signal_DSB_LC,Carrier_Frequency,Modulation_Sampling_Rate,'amdsb-tc',Modulation_Index);
demodulated_DSB_LC_L_SAMPLE=resample(demodulated_DSB_LC,Sampling_Rate,Modulation_Sampling_Rate);
t = (0:length(demodulated_DSB_LC_L_SAMPLE)-1)/Sampling_Rate;

%{
----------another way but not working well------------------
order_2=2;

% Design the low-pass filter
lpf = designfilt('lowpassfir', 'FilterOrder', order_2, 'CutoffFrequency', cutoff_freq, 'SampleRate', Modulation_Sampling_Rate);

% Apply the filter to the input signal
filtered_signal = filter(lpf,mod_signal_DSB_LC );

% Rectify the filtered signal to extract the envelope
envelope = abs(filtered_signal);
envelop_L_SAMPLE=resample(envelope,Sampling_Rate,Modulation_Sampling_Rate);
%}
%----------------------------------------------------------------
%-------------------PLOT DEMODULATED SIGNAL------------------------
%----------------------------------------------------------------
figure(1);
subplot(time_plot_no,2,5);
plot(t, demodulated_DSB_LC_L_SAMPLE);
xlabel('Time');
ylabel('Amplitude');
title('Demodulated Envelope Signal');
disp('demodulation DSB-LC signal playing now....');
% Plot the modulated signal in the frequency domain
N = length(demodulated_DSB_LC_L_SAMPLE);
f = (-N/2:N/2-1)*Sampling_Rate/N;
mod_signal_fft = abs(fftshift(fft(demodulated_DSB_LC_L_SAMPLE)));
figure(2);
subplot(frequency_plot_no,2,5);
plot(f, mod_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Modulated (DSB-LC)Signal Spectrum');
%----------------------------------------------------------------
%------------------REPLAY DSB_LC DEMOD RECORDING-----------------
%----------------------------------------------------------------
%play the record
disp('PLAYING THE DSB_LC DEMOD RECORDING...');
sound(demodulated_DSB_LC_L_SAMPLE,Sampling_Rate);
pause(length(demodulated_DSB_LC_L_SAMPLE)/Sampling_Rate);
%----------------------------------------------------------------
%----------------CALCULATE POWER AND DISPALY IT------------------
%----------------------------------------------------------------
DSB_LC_signal_Power=rms(demodulated_DSB_LC_L_SAMPLE)^2;
disp('DSB_LC_signal_Power -->');
disp(DSB_LC_signal_Power);