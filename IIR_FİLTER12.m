% IIR filter scan app
% Butterworth Analog filter and digitization 
% design requirements
wc = 2*pi*100;   wp = 2*pi*50; ws = 2*pi*150; d1=0.15;   d2=0.1;
Ts = 1/3000; 
ww = 0:pi/Ts; 
N = 7;
% Let's design a Butterworth filter
[b,a] = butter(N,wc,'s')
[Hb] = freqs(b,a,ww);
figure(7)
subplot(211),plot(ww/(2*pi),abs(Hb),[0 wp]/(2*pi),(1+d1)*[1 1],'k--',[0 wp]/(2*pi),(1-d1)*[1 1],'k--',[ws ww(end)]/(2*pi),(d2)*[1 1],'k--'),grid,axis([0 ww(end)/(2*pi) ylim]),xlabel('frekans, Hz'),ylabel('Amplitude')
subplot(212),plot(ww/(2*pi),angle(Hb)*180/pi),grid,axis([0 wp(end)/(2*pi) ylim]),xlabel('frequency, Hz'),ylabel('Phase')
% Let's digitize
[B,A] = tfdata(c2d(tf(b,a),Ts,'tustin'),'v')
[H,w] = freqz(B,A,256);
figure(8)
subplot(211),plot(w/(2*pi),abs(H),Ts*[0 wp]/(2*pi),(1+d1)*[1 1],'k--',Ts*[0 wp]/(2*pi),(1-d1)*[1 1],'k--',[Ts*ws w(end)]/(2*pi),(d2)*[1 1],'k--'),grid,axis([0 0.5 ylim]),xlabel('Normalized frequency'),ylabel('Amplitude')
subplot(212),plot(w/(2*pi),angle(H)*180/pi),grid,axis([0 0.5 ylim]),xlabel('Normalized frequency'),ylabel('Phase')
