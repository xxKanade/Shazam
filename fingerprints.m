function hashtable = fingerprints(s)
% Programmed by Steven Van Vaerenbergh (January 2005).
% https://github.com/steven2358/Shazam-Matlab
% This function was taken from the public repository above however it was
% edited slightly so that it would work with our program.

% The function takes the STFT of the input mono sound vector s using
% windowing and then creates a hashtable of the larger frequencies to
% create the fingerprints and construct a hashtable.
% Instead of using a spectrogram function this code explicitly represents 
% it using w implementations of the FFT at the respective times where w is 
% # of windows. This is done using by multiplying the fft by the window for
% every window and then finding the maximum frequencies in that window.
% This find the fingerprints.  

% Those fingerprints are then put into a hashtable which is represented as
% a cell and the function fingerprints(s) outputs this hashtable in the
% form of a cell for the input s, which once again is the discrete values
% of the audio file.

fs = 10000;         % Arbitrarily chose sampling frequency of 10 kHz.

wlen = fs*0.05;     % Window length in samples, chosen to be 5ms.
olen = wlen/2;      % Overlap length which is up to half of window length.
slen = length(s);   % Length of discrete song indices.

% Target window definitions needed for function "fingerprints.m".
t_mindelta = 1; 
t_maxdelta = 20;
t_freqdiff = 10;


% number of windows:
num_win = floor((slen-olen)/(wlen-olen));

% voor fft
midind = wlen/2+1;

specpeaks = zeros(num_win,1);
h = waitbar(0,'Calculating peaks...');
for w_ind = 1:num_win,
	waitbar(w_ind/num_win,h);
	wstart = (w_ind-1)*(wlen-olen)+1;
	wend = wstart + wlen - 1;
	
	win = s(wstart:wend).*hamming(wlen);
	fwin = abs(fft(win));
	[maxpeak,maxind] = max(fwin);
	specpeaks(w_ind) = maxind;
end
close(h)

% hash table, indices: original freq, freq diff, time diff
% t_diffrange = t_maxdelta-t_mindelta+1;
hashtable = cell(wlen/2+1,2*t_freqdiff+1,t_maxdelta);



% fill hash table
h = waitbar(0,'Filling hash table...');
for w_ind = 1:num_win,
	waitbar(w_ind/num_win,h);
	thisfreq = specpeaks(w_ind);
	for delta_ind = t_mindelta:min(t_maxdelta,num_win-w_ind),
		targetfreq = specpeaks(w_ind + delta_ind);
		freqdiff = targetfreq - thisfreq;
		if (abs(freqdiff) <= t_freqdiff)
			freqdiff_ind = freqdiff + t_freqdiff + 1;
			hashtable{thisfreq,freqdiff_ind,delta_ind} = [hashtable{thisfreq,freqdiff_ind,delta_ind};w_ind];
		end
	end
end
close(h)
