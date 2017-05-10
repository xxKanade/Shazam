% Takes as inputs the desired size of the hash table and a list of file
% names in the directory to store. Each file will be fingerprinted and
% stored in the hash table. The first column of the hash table stores the
% song IDs and the second column stores the max peaks

function hash_table = createHash(hash_size,songnames)
    % Allocate memory for the hash_table
    hash_table = cell(hash_size,2);
    % iterate through each song in the list
    for songid = 1:length(songnames);
        % read each song file
        [song,fs] = audioread(songnames{songid});
        % fingerprint each song
        peaks = fingerprints(song,fs);
        % hash the peak values from each section of the fingerprint
        for i = 1:length(peaks)
            hash = mod(peaks(i),hash_size) + 1;
            % store the peak frequency
            hash_table{hash,2}(end+1) = peaks(i);
            % store the song ID
            hash_table{hash,1}(end+1) = songid;
        end
    end
end
