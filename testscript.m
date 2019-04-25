%% test script 2019


clear all;
close all 

% sample = load('f4.mp3','-mat');
[y,Fs] = audioread('f4.mp3');
% lets spectrogram at 44.1 and then filter, then resample at 8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Filter code!
% Fs = sample.Fs;         
T = 1/Fs;                   
L = length(y(:,1));         
t = (0:L-1)*T;
thresh = 5000;


clear sound


