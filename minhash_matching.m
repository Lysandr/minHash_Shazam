function [songName,mofreq_val,mofreq_quant] = ...
    minhash_matching(testOption,clip,hashTable, ...
    songNameTable,gs,deltaTL,deltaTU,deltaF)

% testOption is not used in part1
% clip is the name of the clip file
% hashTable is the full data base hashed table
% songNameTable is the fuull data base table

%TESTING
% clip = 'sample.mat';
% deltaTU = 6;
% deltaTL = 3;
% deltaF = 9;
% gs = 9;


Cliptable = make_table(clip,gs,deltaTL,deltaTU,deltaF);
Cliphashtable = minhash(Cliptable);
matchMatrix = [];
% hashTable = sortrows(hashTable, 2);
tic

lower = 1;

for i = 1:size(Cliphashtable)
    matchIndicies = find(Cliphashtable(i,1) == hashTable(:,1));
    matchMatrix = [matchMatrix; hashTable(matchIndicies,3)];
end

matchtime = toc;

[n,bin] = hist(matchMatrix,unique(matchMatrix));
[~,idx] = sort(-n);
mofreq_val = bin(idx);
mofreq_quant = n(idx).';

save('matchMatrix','matchMatrix');
[songnumber,F] = mode(matchMatrix);
songName = songNameTable(songnumber,:);

end
