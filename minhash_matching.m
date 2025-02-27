function [songName] = ...
    minhash_matching(testOption,clip,hashTable, ...
    songNameTable,gs,deltaTL,deltaTU,deltaF)

Cliptable = make_table(clip,gs,deltaTL,deltaTU,deltaF);
Cliphashtable = minhash(Cliptable);
matchMatrix = [];

%% original Mode Based Matching algorithm (naive)
% for i = 1:size(Cliphashtable)
%     matchIndicies = find(Cliphashtable(i,1) == hashTable(:,1));
%     matchMatrix = [matchMatrix; hashTable(matchIndicies,3)];
% end
% 
% [n,bin] = hist(matchMatrix,unique(matchMatrix));
% [~,idx] = sort(-n);
% mofreq_val = bin(idx);
% mofreq_quant = n(idx).';
% 
% save('matchMatrix','matchMatrix');
% [songnumber,F] = mode(matchMatrix);
% if isnan(songnumber)
%     songName = NaN;
% else
%     songName = songnumber;
% end

%%  Knearest neigbours
% test_subset     = randsample( 1e4, 16e2  );
% TestPoints      = Test(test_subset,:);
% TestLabels      = Test_labels( test_subset );

% test_subset = randsample( 700, 350  );
% TestPoints      = Test(test_subset,:);

% K = 10;   % # of nearest neighbors to use
% Train = reshape(hashTable(:,1),700,50).';
% test_set= Cliphashtable.';
% D   = pdist2_faster(Train, test_set);
% [~,Ind]   = sort(D); % per row, sort the columns
% 
% Train_labels = [1:50].';
% labels      = Train_labels(Ind(1:K,:) );
% intermode = mode(labels,1); % just for debug
% songName  = mode(intermode);
% disp('did something');


%% convolution maximization

% conv_out = conv(Cliphashtable,hashTable(:,1));
% maximum = max(max(conv_out));
% [x,y]=find(A==maximum)


%% Window search the hash functions
k = 500;
song_score = 0;
for i = 1:50
    hashTable_sentence = hashTable((i-1)*k+1: i*k,1);
    local_sens_bool = abs(Cliphashtable-hashTable_sentence) <= 100;
%     local_sens_bool = 1.*local_sens_bool + ...
%         1.*(Cliphashtable == hashTable_sentence);
    local_score = sum(local_sens_bool);
    if song_score < local_score
        song_score = local_score;
        songName = i;
    end
end
songName;
disp('');




