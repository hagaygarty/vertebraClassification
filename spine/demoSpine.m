% this demo will get MNIST data automatically and start a training on network specified in 'mnist.conf'
% it will reach 94% in several minutes, 99.2% in couple of hours

addpath('../../Trainning' , '../../mdCNN' );

net = CreateNet('../../Configs/spine.conf'); 

spineDataset=load('spine.mat');

% start training, will train for 15k images. Reach about 96.30% in several minutes. 
% In order to reach 99.2% remove the last parameter (15k) and let it train longer.
% It will stop trainning automatically (once ni reach below thresh)
net   =  Train(spineDataset.images,net);
