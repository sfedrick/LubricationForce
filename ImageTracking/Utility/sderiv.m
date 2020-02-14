function result = sderiv(series)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KDERIV - Take a derivative using fourier math to avoid awful numerical
% effects.  Prepare to be amazed!

% Other than this comment, everything here was written by KE Daniels. She
% is

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L =size(series);
series = series - mean(series);

L(2)
k = 1:L(2);
newseries=fft(series);
endpoint=size(newseries)
for i=1:endpoint(2)
    newseries(i)=complex(0,1)*2*pi*i*newseries(i);
end
result = ifft(newseries)
plot(result);
result = real(result(1:L));
return;
