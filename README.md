# vertebraClassification
vertebra classification files. Dataset for training the deep net and config files

This is the dataset trainning files and trained networks to classify Vertebra in spinal cord.

Using Deep learning to identify and classify Vertebrae into one of the 26 possible classes (C1-S4). The deep net will be able to identify centralized Vertebrae, in a specific size. 

In order to train first download mdCNN from:
https://github.com/hagaygarty/mdCNN

Then put the 'spine' folder inside mdCNN demo folder.
Unzip the Dataset files , place 'spine.mat' inside 'spine' folder.
Then call 'demoSpine.m' , the trainning process will begin. You can see the 'scesRate=' strarting from 9.59 % and rising.


In order to classify using the pretrained network - unzip the 'Nets.7z' files, please the networks in the 'spine' folder.
You can use net.mat as the main network.

=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~
To run the network on the test dataset set matlab folder to 'spine' then run:

addpath('../../Trainning' , '../../mdCNN', '../../utilCode');

spineDataset=load('spine.mat'); 

load('net.mat');

checkNetwork(net,Inf,spineDataset.images,1);
=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~

For 78.0% classification net run:

load('net_maxS.mat');

checkNetwork(net_maxS,Inf,spineDataset.images,1);

wait for several minutes, the results will show


