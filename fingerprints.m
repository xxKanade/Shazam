function peaki = fingerprints(y,fs)
% fingerprints function inputs the discrete values of a song and the
% sampling frequncy associated and it outputs the maximum peaks of the STFT
% for every corresponding time lenght.

% Take left channel of song to make mono.
y = y(:,1);

% Resample the song to reduce time it takes to compute. fs reduced to 12000
% from 48000. Reduction by factor of 4.
fsn = 12000;
y = resample(y, fsn, fs);

% Spectrogram function uses STFT.  Windowed at 128 with 1/2 of that as
% overlap or 64.  The frequencies are dependent on the new resampled fsn.
[s,~,~] = spectrogram(y, 128, 64, [], fsn);
mag = abs(s);

% Calculate max frequencies of each time index.

[~,peaki] = max(mag);

end