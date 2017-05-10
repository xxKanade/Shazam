% match() has input arguments sound clip z and sampling frequency Fs.
% With these parameters match() attempts to find a matching song within
% songDatabase

function match = search(z, Fs)
    % global variables
    global songDatabase
    global ttlSongs

    [s,w,t] = spectrogram(z);
    Y = fft(z);                      % fft with N = 5000 samples

    matches = cell(ttlSongs, 1)
    for k = 1:size(key, 1)
        hash = hashme



end
