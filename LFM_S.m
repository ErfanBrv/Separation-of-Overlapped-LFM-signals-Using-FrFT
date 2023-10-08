function y = LFM_S(T,B,fc,fs)
t = 0:1/fs:T-1/fs; t = t(:);
y = zeros(size(t,1),1);
for ii    =  1:size(t,1)
    y(ii) =  exp(1i*2*pi*( B/(2*T)*t(ii)^2 + (fc-B/2)*t(ii)  ));
end



y = real(y).*hann(size(y,1));
% plot(t,y,'k'); %plots figure
% % axis ([-1.1 1.1]);
% title('Time Domain')
% xlabel('seconds'); 
% title('sine signal with decay');
% freq_res = 0:fs/size(t,1):fc+B/2;
% figure,plot(abs(fft(y)),'k')
% title('Frequency Domain')
% xlabel('frequency')

end