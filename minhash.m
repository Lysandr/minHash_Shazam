function minhashTable = minhash(table)
%%minhash 
    
    % determine the number of independant hash functions  
    k = 700;
    
    table(:,1) = min(255,table(:,1)-1); % shrink to 8bit, for f_1 entry
    table(:,2) = min(255,table(:,2)-1); % same but for f_2 entry
    
    % Create the shingle: uses f2, f1, and time difference
    shingle_x = table(:,2) + table(:,1)*(2^8) + table(:,4)*(2^16);
    
    % use this for modulo values (next prime after the largest value of
    % shingle)
    w = 16777259;
    max_x = 16777215;
    
    rng(7);
    a = rand(k,1)*max_x;
    b = rand(k,1)*max_x;
    
    h_xm = min(mod(a*shingle_x.' + b, w),[],2);
    
    [~,y] = size(table);
    
    if y>4 % case gets trigger for database construction
        identity = table(1,5);
        ident_buffer = identity.*ones(k,2);
        minhashTable = [h_xm ident_buffer]; %[h_xm table(:,3) table(:,5)];
    else   % case is triggered for clip hashtable generation
        minhashTable = h_xm; %[h_xm table(:,3)];
    end
    

end
