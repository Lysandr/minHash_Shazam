%% Generating small clips
clc; close all; clear all;
testOption = 0;

names = [];
mofreq_vals = zeros(50);
mofreq_quants = zeros(50);

for i = 1:50
    fileName = ['../Shazam_16/Shazam_minhash/songDatabase/',num2str(i,'%02.f'),'.mat'];
    sample = load(fileName,'-mat');
    Fs = 8000;
    y = resample(sample.y(:,1),Fs,sample.Fs);
    q=length(y);
    clip_start = 0.1*q;
    clip_end = clip_start + 10*Fs;
    y  = y(ceil(clip_start): floor(clip_end));
    % adding noise because why not
    y = y + randn(size(y))*1e-3;
    clip.y = y;
    clip.Fs = 8000;
    tic
    [name,freqs,quants] = main_minhash(testOption,clip);
    names = [names;name];
    mofreq_vals(1:length(freqs),i) = freqs;
    mofreq_quants(1:length(quants),i) = quants;
    toc
    testOption = 0;
end

correct = sum(1:50 == mofreq_vals(1,:))/50
disp('done');























