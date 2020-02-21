SNRInDb = [0:2:35];
for QAM = [4, 16, 64, 256];
    %generating streams of data depending of QAM
    %size :10^-5 is the smallest BER, 1/10^-5 * 10 = 10^6
    stream = randi([0 QAM-1], 10^6, 1);
    
    %modulating the data w/ appropriate QAM
    mod = qammod(stream, QAM);
    
    for SNR = 1:length(SNRInDb)
        signal_noise=awgn(mod, SNRInDb(SNR), 'measured');
        Dem=qamdemod(signal_noise, QAM); 
        errno = biterr(stream,Dem); 
        %BER = (amount bits - error bits) / amount bits
        BER(QAM, SNR) = (errno)/ length(stream);    
    end
end
semilogy(SNRInDb, BER(4,:), SNRInDb, BER(16,:), SNRInDb, BER(64,:), SNRInDb, BER(256,:));