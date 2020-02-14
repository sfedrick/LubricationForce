function result = kderiv(series)
L = length(series);
series = series - mean(series);
series = [series(:); reverse(series)]; % to avoid end effects

k = omega(length(series), 1)';
result = ifft(complex(0,1)*2*pi*k.*fft(series));
result = real(result(1:L));
return;
