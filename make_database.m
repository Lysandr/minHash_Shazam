function make_database(gs,deltaTL,deltaTU,deltaF)

% deltaTU = 6;
% deltaTL = 3;
% deltaF = 9;
% gs = 9;

table =[];
songNameTable = [];
for i = 1:50
    if i<10
        songName = strcat('0', num2str(i), '.mat');
    else
        songName = strcat(num2str(i), '.mat');
    end
    songNameTable = [songNameTable; songName];
    tbl = make_table(songName,gs,deltaTL,deltaTU,deltaF);
    table = [table; [tbl (i*ones(length(tbl),1))]];
end

hashTable = hash(table);
save hashTable.mat hashTable
save songNameTable.mat songNameTable

end