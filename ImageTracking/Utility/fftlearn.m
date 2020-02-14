Fs = 1000;                    % number of samples taken every second 
T = 1/Fs;                     % simply the period a which samples are taken pretty useless it seems 
L = 50000;                     % number of samples that were taken 
t = (0:L-1)*T;                % Time vector
% Sum of a 50 Hz sinusoid and a 120 Hz sinusoid

x = 0.7*sind(450*t); 

%y = 0.7*sind(500*t) + sind(100*t);    % Sinusoids 
y=x;
figure(1)
plot(t,x)
title('Signal')
xlabel('time seconds')
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
y=y;
Y = fft(y/L);
f = shaunomega(L, T);
invert=ifft(Y);
% Plot single-sided amplitude spectrum.
figure(2)
plot(f,abs(Y)) 
title('Double-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
figure(3)
plot(t,invert)

