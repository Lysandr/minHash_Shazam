function hashTable = hash(table)

    table(:,1) = min(255,table(:,1)-1); % decrease to 8bit value
    table(:,2) = min(255,table(:,2)-1); % same

    hashedval = table(:,2) + table(:,1)*(2^8) + table(:,4)*(2^16);
    
    [x,y] = size(table);
    
    if y>4 % case gets trigger for database construction
        hashTable = [hashedval table(:,3) table(:,5)];
    else   % case is triggered for clip hashtable generation
        hashTable = [hashedval table(:,3)];
    end
    

end
