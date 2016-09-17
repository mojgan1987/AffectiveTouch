% filename = 'moj0.txt';
% delimiterIn = '\n';
% headerlinesIn = 1;
% A = importdata(filename,delimiterIn,headerlinesIn);


%%
% To Run
% 1. CHange he nuber of files
% 2. Change the participan name
% 3. Change the folder name

%%
close all
clear all
%One less than reall
numOfFiles = 67;
parname = 'rirardo2';
% FeatureVector = zeros(numOfFiles, 28);
% FeatureVector = zeros(numOfFiles, 25);
% Ang
FeatureVector = zeros(numOfFiles, 29);
% FeatureVector = zeros(numOfFiles, 31);

for i = 0:numOfFiles
    fileName = strcat(parname, '/', parname, '_', int2str(i), '.txt');
    fileID = fopen(fileName);
    C = textscan(fileID,'%s');
    fclose(fileID);
%     celldisp(C);

    Bb = [C{:}];

    sz = size(Bb);
    cloSize1 = sz/6;
    colSize=cloSize1(1);
    Tmp = Bb(1:6);
    for n = 1 : colSize-1
        tmp = Bb(n*6+1:(n+1)*6);
        Tmp = horzcat(Tmp , tmp);
    end
    
    %Calling to the feature extractor function
%     FeatureVector(i+1,5:24) = featureExtraction(Tmp);
%   Ang
    FeatureVector(i+1,5:28) = featureExtraction(Tmp);
%     FeatureVector(i+1,5:27) = featureExtraction(Tmp);
%     FeatureVector(i+1,5:30) = featureExtraction(Tmp);
    %Dist to the first touch
%     FeatureVector(i+1, 28) = FeatureVector(i+1, 1) - FeatureVector(1, 1);
%   Ang
    FeatureVector(i+1, 29) = FeatureVector(i+1, 1) - FeatureVector(1, 1);
%     FeatureVector(i+1, 25) = FeatureVector(i+1, 1) - FeatureVector(1, 1);
%     FeatureVector(i+1, 31) = FeatureVector(i+1, 1) - FeatureVector(1, 1);
    
    %Adding time
    FeatureVector(i+1, 1) = str2num(Tmp{6,1});
    FeatureVector(i+1, 2) = str2num(Tmp{6,end});
    %Touch Length
    FeatureVector(i+1, 3) = FeatureVector(i+1, 2) - FeatureVector(i+1, 1);
    %Dist to the previous Tch
    if(i>=1)
        FeatureVector(i+1, 4) = FeatureVector(i+1, 1) - FeatureVector(i, 2);
    end
    
%     FeatureVector(i+1, 28) = FeatureVector(i+1, 1) - FeatureVector(1, 1);
%     FeatureVector(i+1, 25) = FeatureVector(i+1, 1) - FeatureVector(1, 1);
%  Ang
    FeatureVector(i+1, 29) = FeatureVector(i+1, 1) - FeatureVector(1, 1);
%     FeatureVector(i+1, 31) = FeatureVector(i+1, 1) - FeatureVector(1, 1);
    
    %%
    %Writing to text file
    filename = strcat(parname,int2str(i), '.txt');
    fileID = fopen(filename,'w');
%    
    %Creating a formatSpec
    [r, c] = size(Tmp);
    formatSpec = '';
    for fs=1:c
        formatSpec = strcat(formatSpec, '%s\t');
    end
    
    formatSpec = strcat(formatSpec, '\n');
    
    [nrows,ncols] = size(Tmp);
%     for row = 1:nrows
%         fprintf(fileID,formatSpec,Tmp{row,:});
%     end
    fclose(fileID);
    
    PlotTch(Tmp)

end
    print(strcat(parname,'_tch.bmp'),'-dbitmap')
    savefig(strcat(parname,'_Net_Emo.fig'))

% FeatVec = [FeatureVector(:,28) FeatureVector(:,1:27)];
% FeatVec = [FeatureVector(:,25) FeatureVector(:,1:24)];
% Ang
FeatVec = [FeatureVector(:,29) FeatureVector(:,1:28)];
