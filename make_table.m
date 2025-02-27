function table = make_table(clip,gs,deltaTL,deltaTU,deltaF)

close all 
% lets spectrogram at 44.1 and then filter, then resample at 8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Filter code!
% Fs = sample.Fs;           
% T = 1/Fs;                   
% L = length(sample.y(:,1));         
% t = (0:L-1)*T;
% thresh = 5000;

Y = fft(clip.y(:,1)); % take fft
% Y = fftshift(Y); % shift over to right!
% f = Fs*(1:L)/L;
% figure; plot(f,Y);

% Lf = length(Y);
% ratio=(thresh/Fs);
% M = ceil(Lf/2);
% length(1:M-ratio*M)
% length(M+ratio*M:Lf)
% Y(1:M-ratio*Lf) = 0;
% Y(M+ratio*Lf:Lf) = 0;
% figure; plot(f,Y);
% Y = ifftshift(Y);
Y = ifft(Y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fs = 8000;
y = resample(Y, 8000, clip.Fs); %resamples the input sequence, x, at p/q ti


window = 64e-3 ;
noverlap = 32e-3;
nfft = 64e-3;
[S,F,T] = spectrogram(y, window*Fs, noverlap*Fs, nfft*Fs, Fs);

log_S = log10(abs(S)+1);
% 
% figure;
% imagesc(T,F,20*log10(abs(S)));
% axis xy;
% xlabel('Time (s)')
% ylabel('Frequency (kHz)')
% title('Spectrogram')
% colormap jet
% c= colorbar;
% set(c);
% ylabel(c,'Power (dB)','FontSize',14);


n=0;
thirtypersecond=floor(30*length(y)/8000+.5);
upper=1;
lower=0;
thresh = 0.5883;
% gs = 9; % Remove for generalized function
dim = floor(gs/2);

localPeak = ones(size(log_S));
for i = -dim:dim
    for j = -dim:dim
        if i ~=0 || j ~=0
            CS = circshift(log_S,[i j]);
            thing = ((log_S - CS) > 0);
            localPeak = localPeak .* thing;
        end
    end
end


%% filter 30 per second
%could implement another way - sort peaks by height and take all up to
%index thirtypersecond. Thresh is the height of that thirtypersecond'th
%peak.


while (n ~= thirtypersecond)
    tempthing = localPeak.*log_S;
    tempthing = tempthing>thresh;
    n = nnz(tempthing);
    if (n > thirtypersecond)
        lower=thresh;
        thresh=thresh+.5*(upper-thresh);
    elseif (n < thirtypersecond)
        upper=thresh;
        thresh=.5*(thresh-lower);
    else
        break
    end
end
localPeak=tempthing;
%END PART 4. localPeak is boolean matrix, n=number of peaks=thirtypersecond

%% fanout search
% deltaTL=3; %Remove for generalized function
% %dTL=Fs*deltaTL;
% deltaTU=6; %Remove for generalized function
% %dTU=Fs*deltaTU;
% deltaF=9; %Remove for generalized function

fanOut=3;

[freqI,timeI]=find(localPeak);
tbl=[];
for i = 1:n
    cds = (timeI >= timeI(i) + deltaTL)&(timeI <= timeI(i) + deltaTU)&...
        (freqI >= freqI(i) - deltaF)&(freqI <= freqI(i) + deltaF);
    q = find(cds, fanOut); lenq = length(q);
    if lenq > 0
       tbl = [tbl; [freqI(i)*ones(lenq,1) freqI(q) timeI(i)*ones(lenq,1) timeI(q)-timeI(i)*ones(lenq,1)]];
    end

end

table = tbl;

% tbl=[];
% [f,t]=size(localPeak);
% N=0;
% for i = 1:n % for each of the peaks...
%     indices = find(localPeak, i);
%     index = indices(end);
%     lbf = max(1,index-deltaF);
%     ubf = min(f,index+deltaF);
%     rangef = lbf:ubf;
%     
%     lbt = min(t, index+deltaTL);
%     ubt = min(t, index+deltaTU);
%     ranget = lbt:ubt;
%     
%     points=localPeak(rangef, ranget);
%     q = find(points, fanOut); % gives you indices of first fanOut number of nonzero elements
%     lenq = length(q);
%     if ~isempty(q)
%         q;
%         points;
%         N=N+length(q);
% %         freqI = 
% %         tbl = [tbl; freqI*ones(lenq,1) freqI(lenq) timeI(i)*ones(lenq,1) timeI(lenq)-timeI(i)*ones(lenq,1)];
%     end
% end





% OLD WAY

% 
% [freqindicies,timeindicies]=find(localPeak);
% freqindicies= F(freqindicies)';
% timeindicies= T(timeindicies);
% pairs(1:n)=0;
% tbl=[];
% for i = 1:n
%     for j= deltaTL:deltaTU
%         if i+j <= n
%             
%             if(abs(freqindicies(j+i)-freqindicies(i)) <= deltaF*15.625)
%                 pairs(i)=pairs(i)+1;
%                 tbl=[tbl;[freqindicies(i),freqindicies(j+i),timeindicies(i),timeindicies(j+i)-timeindicies(i)]];
%                 if (pairs(i) == fanOut)
%                     break % out of inner loop. No more pairs for this guy
%                 end
%             end
%         end
%     end
% end


end
