%% Generating small clips
clc; close all; clear all;
testOption = 1;

names = [];
mofreq_vals = zeros(50);
mofreq_quants = zeros(50);

for i = 1:50
    % Resample the clip data
    fileName = ['../Shazam_16/Shazam_minhash/songDatabase/',num2str(i,'%02.f'),'.mat'];
    sample = load(fileName,'-mat');
    Fs = 8000;
    y_og = resample(sample.y(:,1),Fs,sample.Fs);
    q=length(y_og);
    
    % Calculate the time frame to generate clips
    clip_start = 0.5*q;
    clip_end = clip_start + 22*Fs;
    if clip_end > q
       clip_end = q; 
    end
    
    % truncate for clip and add noise because why not
    y  = y_og(ceil(clip_start): floor(clip_end));
    y = y + randn(size(y))*1e-1;
    clip.y = y;
    clip.Fs = Fs;
    
    % run the search function on the clip
    tic
    [songName] = main_minhash(testOption,clip);
    names = [names; songName];
%     mofreq_vals(1:length(freqs),i) = freqs;
%     mofreq_quants(1:length(quants),i) = quants;
    toc
    if songName == i
        disp(songName)
    end
    testOption = 0;
end

correct = sum([1:50].' == names)/50
disp('done');























