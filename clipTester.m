%% Generating small clips
clc; close all; clear all;

tic
Fs = 8000;
songNamefirst = '04.mat';
sample = load(songNamefirst,'-mat');
y = resample(sample.y(:,1),8000,sample.Fs);
q=length(y);
clip_start = 0.30*q;
clip_end = clip_start + 10*Fs;
y  = y(ceil(clip_start):ceil(clip_end));
y = y + randn(size(y))*1e-3;
soundsc(y,Fs)
save('clip','y','Fs')
toc


%% Start the test
clear all; clc;
clipName = 'clip.mat';
% generate a new hashtable?
testOption = 1;

tic
[songName,mofreq_val,mofreq_quant] = main_minhash(testOption,clipName);
toc

disp('done');
% if songName == songNamefirst
%    disp('SUCCESS HAS BEEN HAD') 
% else
%     disp('FAILURE HAS BEEN HAD')
% end


%% testing
% clear all;
% forty_two = load('42','-mat');
% clip = load('clip','-mat');


