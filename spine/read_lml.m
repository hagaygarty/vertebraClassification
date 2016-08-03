function L = read_lml(filename)

fid = fopen(filename,'r');

%disp(['Loading spine landmark file: ' filename '...']);
fgetl(fid);

count = 1;
while feof(fid) == 0
    
    line = fgetl(fid);
    [id,r] = strtok(line);
    [name,r] = strtok(r);
    pos = sscanf(r,'%f');
        
    L(count).id = id;
    L(count).name = name;
    L(count).pos = pos;
    
    count = count + 1;
    
end

%disp([num2str(length(L)) ' landmarks found: '  L(1).name ' -> ' L(end).name]);

fclose(fid);
