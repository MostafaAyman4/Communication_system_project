%----------------------------------------------------------------
%-----------------------LOW PASS FILTER--------------------------
%----------------------------------------------------------------
cutoff_freq = 3400;
order = 100;
b = fir1(order, cutoff_freq/(Sampling_Rate/2),'low');
filtered_signal = filter(b, 1, Signal_values);

%----------------------------------------------------------------
%---------PLOT IN FREQUECNY DOMAIN THE FILTERED SIGNALR----------
%----------------------------------------------------------------
N = length(filtered_signal);
f = (-N/2:N/2-1)*Sampling_Rate/N;
Filtered_signal_fft = abs(fftshift(fft(filtered_signal)));

subplot(3,1,3);
plot(f, Filtered_signal_fft);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Filtered Signal Spectrum');

%----------------------------------------------------------------
%------------------REPLAY-fILTERED RECORDING---------------------
%----------------------------------------------------------------
%play the record
sound(filtered_signal,Sampling_Rate);
pause(length(filtered_signal)/Sampling_Rate);
