songList = dir('Resources');
numberofSongs = numel(songList);
songTitle = [];
for k = 4:numberofSongs
    information = songList(k);
    for i = 0:numberofSongs-4
    songTitle(i) = information.name
    end
end