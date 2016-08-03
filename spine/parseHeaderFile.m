function [ L ] = parseHeaderFile( headrFile )

    hFil=fopen(headrFile);
  %  disp(['Loading spine landmark file: ' headrFile '...']);
    fgetl(hFil);

    count = 1;
    while feof(hFil) == 0

        line = fgetl(hFil);
        [id,r] = strtok(line);
        [name,r] = strtok(r);
        pos = sscanf(r,'%f');

        L(count).id = id;
        L(count).name = name;
        L(count).pos = pos;

        count = count + 1;

    end

    fclose(hFil);
end

