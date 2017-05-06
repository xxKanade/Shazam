% This m-file is designed to construct the fingerprints of every song in
% the song folder and save the corresponding hashtables in the hash folder.
% This program only needs to be run once if there are no hashtables in the
% hash library or if a new song is added to the library.

clc; clear; close;

songdir = 'songs\';
hashdir = 'hashtables\';

fs = 10000;         % Arbitrarily chose sampling frequency of 10 kHz.

wlen = fs*0.05;     % Window length in samples, chosen to be 5ms.
olen = wlen/2;      % Overlap length which is up to half of window length.

% Target window definitions needed for function "fingerprints.m".
t_mindelta = 1; 
t_maxdelta = 20;
t_freqdiff = 10;

% Extraction of song names from folder into cell array using for loop.
sdir = dir(songdir);
sdirlen = length(sdir);
songnames = [];
songnames2 = [];
for i = 3:sdirlen,                        % Start looping at 3 where songs start.
	sn = sdir(i).name;                    % Extracts the name from the files.
	songnames{i-2} = sn(1:length(sn));    % Save songnames with filetype for audioread.
    songnames2{i-2} = sn(1:length(sn)-4); % Save songnames without filetype for hashtable.
end

save songnames;
save songnames2;
amt = length(songnames);                  % Amount of songs in file.



for i = 1:amt,
    % Construct exact file location for audioread fuction for every
    % songname.
    filename = sprintf('%s%s',songdir,songnames{i});    
    
    s = audioread(filename); % Get discrete values of the song.
    s = s(:,1);              % Turn into mono if not in mono already.
    
    hashtable = fingerprints(s); % Use function from public repository.
   
    % Saves the hashtable cell in the hashtables folder named as "hashtable
    % songname"
    hashname = sprintf('%shashtable %s',hashdir,songnames2{i});
	save(hashname,'hashtable');
end


