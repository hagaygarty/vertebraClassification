 range=1:500;
         images.I_test = {};
        images.labels_test = {};     
        images.info_test = {};
for idx = range 
        images.I_test{end+1} = images.I{1};
        images.labels_test{end+1} = images.labels{1};     
        images.info_test{end+1} = images.info{1};
     
        images.I(1) = [];
         images.labels(1)  = [];
         images.info(1)=[];
 end
 