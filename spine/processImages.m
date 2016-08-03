function [ images ] = processImages( folder )
images.I={};
images.labels=[];
images.info={};
images.I_test={};
images.labels_test=[];
images.info_test={};
pacients=dir(fullfile(folder,'patient*'));

for pacient=1:length(pacients)
scans =  dir(fullfile(folder,pacients(pacient).name));  
for scan=1:length(scans)
    scanFolder = scans(scan).name;
    if (~isempty(find(isstrprop(scanFolder,'digit')==0, 1)))
        continue;
    end
    fname     =  fullfile(folder,pacients(pacient).name, scanFolder, [scanFolder '.raw']);
    headrFile =  fullfile(folder,pacients(pacient).name, scanFolder, [scanFolder '.mhd']);
    lmlFile   =  fullfile(folder,pacients(pacient).name, scanFolder, [scanFolder '.lml']);
    
    Info = parseHeaderFile(headrFile);
    
    dims = Info(10).pos';

    spacing = Info(9).pos';
    cutSizeMM = [90 90 44];
    sizes= round(cutSizeMM./spacing); % 90mm over 90mm over 44mm
     
    fileID = fopen(fname,'r');
    V = fread(fileID,prod(dims),'int16');
    fclose(fileID);

    V=reshape(V,dims);
    Vpad= padarray(V,ceil(sizes/2));
    
    
   % spacing = spacing ./ finalSpacing;
    
    centFolder='c:\Users\hagayg\Desktop\miccai2013\results\';
    centFile =  fullfile(centFolder,[scanFolder  '_centroids_conf.lml']);
    if (~exist(centFile,'file'))
        centFile = lmlFile;
        fprintf('Missing %s file! reverting to default\n',centFile);
    end
    
    nullLabel=26;
    numTestPacients=10;
    C = read_lml(centFile);
    zeroImages=0;
    sigma=1;
   
    prevCenter=0;
    for idx=1:length(C)
            if (pacient<=numTestPacients)
                numZeroImages=0;
            else
                numZeroImages=zeroImages;
            end
            
        for iter=0:numZeroImages
            if ( iter == numZeroImages)
                label = str2num(C(idx).id)/10-1;
                center = C(idx).pos';
                prevCenter = C(idx).pos';
               % info.type='real';
            else
                label = nullLabel;
               % info.type='dummy';
                if ( iter == 0 )
                    center = prevCenter + (C(idx).pos'-prevCenter)/3;
                elseif ( iter == 1 )
                    center = prevCenter + (C(idx).pos'-prevCenter)/3*2;
                else
                    sz=size(V);
                    center = [randi(sz(1)),randi(sz(2)),randi(sz(3))].*spacing;
                end
            end
            
            
            middle = round(center./spacing);
            starts = middle;
            ends = starts+sizes-1;
           % starts = max(1,starts);
           % ends=min(ends,size(Vpad));
            spine = double(Vpad(starts(1):ends(1),starts(2):ends(2),starts(3):ends(3)));
            if (~isequal(sizes,size(spine)))
                fprintf('Not match\n');
            end
            
            if ( sigma>0)
               spine = imgaussfilt3(spine, sigma); 
            end
            finalSize=[64 64 44];
            spine = imresize3d( spine , finalSize);

            if (1)
            s=reshape(double(spine)/255,[size(spine,1) size(spine,2) 1 size(spine,3)]);
            montage(s);
            end
            
            spine = int16(spine);

            info.scanFolder = scanFolder;
            info.pacient = pacient;
            info.spacing=spacing;
            info.idx=idx;
            info.pos=center;
            info.data=C(idx);

            if (pacient<=numTestPacients)
                images.I_test{end+1}=spine;
                images.labels_test(end+1)=label;
                images.info_test{end+1} = info;
            else
                images.I{end+1}=spine;
                images.labels(end+1)=label;
                images.info{end+1} = info;
            end



            %%%%%%%%%
            if (0)
               dims=size(spine);
               for i=1:dims(end)
                v=double(spine(:,:,i));
                v=v-min(v(:));
                v=v/max(v(:));
                imshow(v);shg
                drawnow
               end
            end
        end
      fprintf('Finished %d/%d, pacient=%s, folder=%s , idx=%d, size=%s, label=%s\n',pacient,length(pacients),pacients(pacient).name,scanFolder,idx,num2str(size(spine)),C(idx).name);
 
           
        %%%%%%%%%
    end
    
end

end

fprintf('Saving database...\n');
save('spine.mat','images','-v7.3');
fprintf('Finished processing images\n');

end
