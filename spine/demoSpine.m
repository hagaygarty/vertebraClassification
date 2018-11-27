% this demo will get MNIST data automatically and start a training on network specified in 'mnist.conf'
% it will reach 94% in several minutes, 99.2% in couple of hours

addpath('../../Training' , '../../mdCNN' , '../../utilCode' );

net = CreateNet('../../Configs/spine.conf'); 

spineDataset=load('spine.mat');

% start training, will train until ni is too small (below thresh specified in spine.conf
net   =  Train(spineDataset.images,net);

checkNetwork(net,Inf,spineDataset.images,1);

showIso(spineDataset.images.I{52},0,1);
showIso(spineDataset.images.I_test{2},0,1);

