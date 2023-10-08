clear 
clc
close all
%% Chrip generation
y = LFM_S(10*10^-6,2.5*10^6,2.5*10^6,100*10^6); % T,B,fc,fs
figure,plot(y)

%% Making a composite signals made from chirps with distinct delays 

component_length = length(y);clear y
T = 25*10^-6 ; fs = 100*10^6; c = 1.5*10^-6; d = 3*10^-6; 
t = 0:1/fs:T-1/fs; t = t(:); t = size(t,1);
initial_delay = 0:1/fs:c-1/fs ; initial_delay = initial_delay(:); initial_delay = size(initial_delay,1);
delay_between = 0:1/fs:d-1/fs ; delay_between = delay_between(:); delay_between = size(delay_between,1);

composite = zeros(t,5);
a = 0.5 ; % decaying factor
 
for k = 1:5
 composite( (1+(k-1)*delay_between+initial_delay) : ((k-1)*delay_between+initial_delay + component_length) , k ) = ...
 a^(k-1) * LFM_S(10*10^-6,2.5*10^6,2.5*10^6,100*10^6);
end

E_t = 0 ;
for i = 1:5
    E_t = composite(:,i) + E_t;
end

figure,plot(E_t)
figure,plot(abs(fft(E_t)))


aa =  -2/pi * (atan(((100*10^6)^2/2500)/(2* (2.5*10^6)/(25*10^-6)))); % alpha resulting in compact singals
figure  ,plot(log(abs(fracF(composite(:,1),aa))))
hold on ,plot(log(abs(fracF(composite(:,2),aa))))
hold on ,plot(log(abs(fracF(composite(:,3),aa))))
hold on ,plot(log(abs(fracF(composite(:,4),aa))))
hold on ,plot(log(abs(fracF(composite(:,5),aa))))

figure  ,plot(log(abs(fracF(E_t,aa))))


%% Extracting one of the chirp from the composite signal 
extr = fracF(E_t,aa); extr = extr(1168:1181,1); 
extr(1:1167)=0;extr(1182:2500)=0;
figure,plot(abs(extr))
extr_t = fracF(extr,-aa);
figure,plot(real(extr_t))
hold on,plot(composite(:,2))
