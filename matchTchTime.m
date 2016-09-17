%%%%%%%%%%%%%%%
% Insert the FaceReader output as frop
%%%%%%%%%%%%%%%
tchStrt = FeatVec(:,1);

% Finding the nearest
for thcntr = 1 : numOfFiles+1
    b = tchStrt(thcntr);
    [value(thcntr),index(thcntr)] = min(abs(b - timeholder));
end

%%Shifting the vector
[r c] = size(FeatVec);
shiftedFeatVec = zeros(r,c);
for sfvcr =1 : size(FeatVec)
    sfvindx = index(sfvcr);
    shiftedFeatVec(sfvindx, :) = FeatVec(sfvcr,:);
end

%Finding AVerage
for avrcr =1 : size(FeatVec)
    up = index(avrcr);
    if(avrcr~=size(FeatVec))
        down = index(avrcr+1);
    end
    if(size(frop) < down)
        break;
    else
        avrfr(avrcr,:) = mean(frop(up:down,:));
    end
end
%%Finding Maximum Indices
%Only 6 emotions
for mc = 1:size(avrfr)
%     [M(mc) indx6e(mc)] = max(avrfr(mc,2:end-3));
    [M(mc) indx(1,mc)] = max(avrfr(mc,2:end-3));
end
% Emotions + contempt
for mc = 1:size(avrfr)
%     [M(mc) indx6cnt(mc)] = max(avrfr(mc,2:end-2));
    [M(mc) indx(2,mc)] = max(avrfr(mc,2:end-2));
end
% Emotion + Neutr + Contemot
for mc = 1:size(avrfr)
%     [M(mc) indxENC(mc)] = max(avrfr(mc,1:end-2));
    [M(mc) indx(3,mc)] = max(avrfr(mc,1:end-2));
end

indxT = indx';

%% Plot
% Emotions + Neutr
figure
plot(frop(:,1:end-3),'DisplayName','Neutr','YDataSource','Neutr');figure(gcf)
axis([0 1500 0 1])
legend('Neutral','Happy','Sad',	'Angry	',	'Surprised	',	'Scared	',	'Disgusted	')
title('6 Basic Emotions + Neutral STate')
xlabel('Frames')
ylabel('Intensity')
print(strcat(parname,'_Net_Emo.bmp'),'-dbitmap')
savefig(strcat(parname,'_Net_Emo.fig'))

%Emotions
figure
plot(frop(:,2:end-3),'DisplayName','Emotions','YDataSource','Emotions');figure(gcf)
axis([0 1500 0 1])
legend('Happy','Sad',	'Angry	',	'Surprised	',	'Scared	',	'Disgusted	')
title('6 Basic Emotions')
xlabel('Frames')
ylabel('Intensity')
print(strcat(parname,'_Emo.bmp'),'-dbitmap')
savefig(strcat(parname,'_Emo.fig'))

%Non Significant Emotions
figure
plot(frop(:,4:end-3),'DisplayName','Emotions','YDataSource','Emotions');figure(gcf)
axis([0 1500 0 1])
legend('Angry	',	'Surprised	',	'Scared	',	'Disgusted	')
xlabel('Frames')
ylabel('Intensity')
title('Other Emotions')
print(strcat(parname,'_NonSig_Emo.bmp'),'-dbitmap')
savefig(strcat(parname,'_NonSig__Emo.fig'))


%% Final Vector
[r1,c1] = size(avrfr);
[r2,c2] = size(FeatVec);
[r3,c3] = size(indxT);
mins = min(r1,r2);
aa = [avrfr(1:mins,:) FeatVec(1:mins,:) indxT(1:mins,:)];

aa2 = [aa(:,11) aa(:,14:end) aa(:,9:10)];