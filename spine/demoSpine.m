% this demo will get train one the spine dataset. Trainning takes about 5 days to finish, you will be able to see the progress due
% successRate will start from ~9% and reach 78.08%

addpath('../../Trainning' , '../../mdCNN' );

net = CreateNet('../../Configs/spine.conf'); 

spineDataset=load('spine.mat');

% start training, will train until ni is too small (below thresh specified in spine.conf)
net   =  Train(spineDataset.images,net);

checkNetwork(net,Inf,spineDataset.images,1);
