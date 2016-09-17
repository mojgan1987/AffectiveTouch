fileID = 'C:\Users\mojga\Documents\FaceReader\Project 1\Logs\Participant 1_Ricardo Ferreiro_Analysis 2_video_20160819_124427_detailed.txt';
myfile = fopen(fileID, 'r');
lno =1;
new = [];
while ~feof(myfile)    
    fline = fgetl(myfile);
%      if(length(fline)>200 && isempty(strfind(fline,'NotAnalyzed')) && isempty(strfind(fline,'FIT_FAILED')) && isempty(strfind(fline,'FIND_FAILED')) && isempty(strfind(fline,'Video')))
    [rowl, coll] = size(fline); 
    if(coll>200 && isempty(strfind(fline,'NotAnalyzed')) && isempty(strfind(fline,'FIT_FAILED')) && isempty(strfind(fline,'FIND_FAILED')) && isempty(strfind(fline,'Video')))
%            if(length(fline)>200 && isempty(strfind(fline,'NotAnalyzed')) && isempty(strfind(fline,'FIT_FAILED')) && isempty(strfind(fline,'FIND_FAILED')) && isempty(strfind(fline,'Video')))
        assert(fline(13) ~= ' ', 'there was a problem in time reading')
        str = fline(13:end);
        C = textscan(str ,'%n', 8);
        assert(size(C{1},1) == 8, 'there was a problem, could not extract numbers')
        tmp = C{1}(1:7)';
        new = [new; tmp];
    end
end
strp = 'Fernando';
strp = strcat(strp(1:strfind(strp,'.txt')),'mat');
save(strp,'new');
fclose(myfile);

figure
plot(new,'DisplayName','test','YDataSource','new');figure(gcf)
axis([0 1500 0 1])
legend('Neutral','Happy','Sad',	'Angry	',	'Surprised	',	'Scared	',	'Disgusted	')
print(strcat(parname,'_Net_Emo.bmp'),'-dbitmap')
savefig(strcat(parname,'_Net_Emo.fig'))

figure
plot(new(:,2:end),'DisplayName','test2','YDataSource','new');figure(gcf)
axis([0 1500 0 1])
legend('Happy',	'	Sad	',	'Angry	',	'Surprised	',	'Scared	',	'Disgusted	')
print(strcat(parname,'_Emo.bmp'),'-dbitmap')
savefig(strcat(parname,'_Emo.fig'))

figure
plot(new(:,4:end),'DisplayName','test2','YDataSource','new');figure(gcf)
axis([0 1500 0 1])
legend('Angry	',	'Surprised	',	'Scared	',	'Disgusted	')
print(strcat(parname,'_NonSig_Emo.bmp'),'-dbitmap')
savefig(strcat(parname,'_NonSig_Emo.fig'))


% figure
% plot(emo_n(:,:),'DisplayName','Normalized','YDataSource','new');figure(gcf)
% axis([0 1500 0 1])
% print('emo_n.bmp','-dbitmap')
% savefig('emo_n.fig')
% 

