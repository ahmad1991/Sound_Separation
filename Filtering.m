addpath('F:\imp. items\biomedical engineering\4th year\1st Semester\Graduation Project\sound libraries\Training B Normal');

%change current directory
%cd('C:\Users\Mohab\Desktop\Training B Normal');

%reads .wav file stores "signal" in "data" and "sampling rate" in "fs"
[data, fs] = wavread('103_1305031931979_B.wav');

%getting number of samples
%m=size(data,1);
%%
%filtering the heartsound alone using lowpass filter "test1"
%y1=filter(test1(fs),data);
%y2=filter(test2(fs),data);
%y3=filter(test3(fs),data);
%amplify the output signal
%Y1=y1.*4;
%Y2=y2.*4;
%Y3=y3.*4;

%%
%spectrogram
[S,F,T,P] = spectrogram(data,256,128,256,fs);

%%
%to convert it to db
db=20*log10(abs(S));
fdb=db;

%visualizing and analyzing the spectrogram to get the threshold value

%%to apply the threshold of 18 db
db(find(db<18))=0;


%visualizing after thresholding
%imagesc(T,F,db);

%get indicies of heart spikes
[j,k]=find (db~=0);
u1=unique(j);
u2=unique(k);

%getting before and after spectrograms
SB=S;
S(u1,u2)=0;
SA=S;
%subtracted spectrogram
H=SB-SA;


%get the time instances of heart spikes
%t=T(u2);

%%
%transforming spectrogram back to signal
[row, column] = size(H);
%clear signl
signal=[];
for i = 1 : column
    
    spectrogramWindow = H(:, i);
    	signalWindow = real(ifft(spectrogramWindow));
    	signal = [signal; signalWindow];
        
end
y1=filter(test1(fs),signal);
SIGNAL=signal.*4;