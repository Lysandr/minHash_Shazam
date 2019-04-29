%% Generating small clips
clc; close all; clear all;
testOption = 0;

names = [];
times = [];
db_N = 50;
duration = 15;

for i = 1:db_N
    % Resample the clip data
    fileName = ['../songDatabase/',num2str(i,'%02.f'),'.mat'];
    sample = load(fileName,'-mat');
    Fs = 8000;
    y_og = resample(sample.y(:,1),Fs,sample.Fs);
    q=length(y_og);
    
    % Calculate the time frame to generate clips
    clip_start = 0.5*q;
    clip_end = clip_start + duration*Fs;
    if clip_end > q
       clip_end = q; 
    end
    
    % truncate for clip and add noise because why not
    y  = y_og(ceil(clip_start): floor(clip_end));
    y = y + randn(size(y))*2e-1;
%     soundsc(y,Fs);
    clip.y = y;
    clip.Fs = Fs;
    
    % run the search function on the clip
    tic
    [songName] = main_minhash(testOption,clip);
    names = [names; songName];
    times = [times; toc];
    toc
    if songName == i
        disp('Correct!')
    end
    testOption = 0;
end

correct = sum([1:50].' == names)/db_N
disp('done');


% disp('15 second clips, 1e-3 noise, 84% accurate')
% disp('15 second clips, 2e-1 noise (totally bollocksed), 66% accurate')
% 
% boxplot([times5 times10 times15 times20 times30],[5 10 15 20 30])
% title('ID time vs Clip Duration');
% ylabel('Seconds');
% set(gca, 'YScale', 'log')
% xlabel('Clip Duration Seconds')





















