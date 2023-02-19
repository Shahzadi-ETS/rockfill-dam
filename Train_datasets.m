clc; clear all;close all;

Inputs = xlsread('Input_parameters.xlsx');
output_INV1 = xlsread('INV1.xlsx');
output_INV2 = xlsread('INV2.xlsx');
output_INH1 = xlsread('INH1.xlsx');
output_INH2 = xlsread('INH2.xlsx');
y1 =  output_INV1(:,:);
y2 =  output_INV2(:,:);
y3 =  output_INH1(:,:);
y4 =  output_INH2(:,:);
x = Inputs(:, :)'%inputs
 Y = [y1 y2 y3 y4]';% targets
net1 = feedforwardnet([640 320 320 320 128], 'trainscg'); %trainlm -- Levenberg-Marquardt, % trainscg -- Scaled Conjugate Gradient , % Bayesian Regularization (trainbr), by default sigmoid activation function is used in this NN.  
net1.trainParam.epochs=60000;
net = train(net1, x, Y);
gregnet_MC_3D = net; % for HS, the datasets will be different
save gregnet_MC_3D

