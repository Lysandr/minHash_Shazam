function make_database_minhash(gs,deltaTL,deltaTU,deltaF)

% deltaTU = 6;
% deltaTL = 3;
% deltaF = 9;
% gs = 9;

table =[];
songNameTable = [];
minhashTable=[];
for i = 1:50
    if i<10
        songName = strcat('0', num2str(i), '.mat');
    else
        songName = strcat(num2str(i), '.mat');
    end
    song = load(['../songDatabase/',songName]);
    tbl = make_table(song,gs,deltaTL,deltaTU,deltaF);
    minhashTable = [minhashTable; minhash([tbl (i*ones(length(tbl),1))])];
    songNameTable = [songNameTable;songName];
end

% hashTable = hash(table);
save minhashTable.mat minhashTable
save songNameTable.mat songNameTable

end
