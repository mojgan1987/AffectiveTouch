function PlotTch(Tmp)
    %Beginning time
    begTime = Tmp(6,1);
    %End Time
    endTime = Tmp(6,end);
    
    %Feature Extraction
    x = hex2dec(Tmp(2,:));
    y = hex2dec(Tmp(3,:));
    MMean = mean(hex2dec(Tmp(4,:)));
    m = mean(hex2dec(Tmp(5,:)));
    
%     figure
%     close all
    hold on
    plot(x, y);figure(gcf)
    axis([0 1600 0 2560])
    

end