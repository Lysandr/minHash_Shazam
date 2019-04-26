function [songName,mofreq_val,mofreq_quant] = main_minhash(testOption,clip)

deltaTU = 12;
deltaTL = 6;
deltaF = 9;
gs = 9;

tic
if testOption == 1 || exist('minhashTable.mat') == 0 || exist('songNameTable.mat')== 0
    make_database_minhash(gs,deltaTL,deltaTU,deltaF)
    tablemad = toc;
    fprintf('It has taken this long to make database: %f \n', tablemad);
end
load('minhashTable.mat')
load('songNameTable.mat')

% [songName,mofreq_val,mofreq_quant] = minhash_matching(testOption, ...
%     clip,minhashTable,songNameTable,gs,deltaTL,deltaTU,deltaF);

[songName] = minhash_matching(testOption, ...
    clip,minhashTable,songNameTable,gs,deltaTL,deltaTU,deltaF);

end