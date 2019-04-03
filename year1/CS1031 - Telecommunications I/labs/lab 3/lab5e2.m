QAM =16;
SNR = 16;
hold on;
stream=randi([0, QAM-1], 10^6, 1);
mod = qammod(stream, QAM);
signal_noise=awgn(mod, SNR, 'measured');
const=comm.ConstellationDiagram('ShowReferenceConstellation', false, 'XLimits', [-4 4], 'YLimits', [-4 4]);
step(const, signal_noise);


%Dem=qamdemod(signal_noise, QAM);
%BER = (size(stream) - sum(stream==Dem))/ size(stream);
%semilogy(SNR, BER)