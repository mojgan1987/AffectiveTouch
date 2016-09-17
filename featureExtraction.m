 function FeatureVector = featureExtraction(Tmp)
    %Beginning time
    begTime = Tmp(6,1);
    %End Time
    endTime = Tmp(6,end);
    
    mat = cellfun(@str2num,Tmp(6,:));
    T =  mat';
    
    M = hex2dec(Tmp(4,:));
    m = hex2dec(Tmp(5,:));
    tchPressure = M./m;
    
    %Feature Extraction
    xMean = mean(hex2dec(Tmp(2,:)));
    yMean = mean(hex2dec(Tmp(3,:)));
    MMean = mean(hex2dec(Tmp(4,:)));
%     mMean = mean(hex2dec(Tmp(5,:)));
    pressureMean = mean(tchPressure);

    xMax = max(hex2dec(Tmp(2,:)));
    yMax = max(hex2dec(Tmp(3,:)));
    MMax = max(hex2dec(Tmp(4,:)));
%     mMax = max(hex2dec(Tmp(5,:)));
    pressureMax = max(tchPressure);

    xMin = min(hex2dec(Tmp(2,:)));
    yMin = min(hex2dec(Tmp(3,:)));
    MMin = min(hex2dec(Tmp(4,:)));
%     mMin = min(hex2dec(Tmp(5,:)));
    pressureMin = min(tchPressure);

    relocationX = xMax - xMin;
    relocationY = yMax - yMin;
    distanceX = hex2dec(Tmp(2,end))-hex2dec(Tmp(2,1));
    distanceY = hex2dec(Tmp(3,end))-hex2dec(Tmp(3,1));

    distance = sqrt(relocationX^2+relocationY^2);

    final_cell = [Tmp{2} Tmp{3} Tmp{4} Tmp{5} Tmp{6}];

    dt = str2double(Tmp(6,end))-str2double(Tmp(6,1));

    timechange = diff(cell2mat(Tmp(6,:)));
    positionchangeX = diff(cell2mat(Tmp(2,:)));
    positionchangeY = diff(cell2mat(Tmp(3,:)));
    
    
    positionchange = ((positionchangeX .^ 2) + (positionchangeY .^ 2)) .^ 0.5;

    averagespeedx = sum(abs(positionchangeX)) ./ (dt);
    averagespeedy = sum(abs(positionchangeY)) ./ (dt);
    averagespeed = sum(positionchange) ./ (dt);
    
    
    %me
    velocityChangeX = diff(positionchangeX);
    velocityChangeY = diff(positionchangeY);
    averageAccelerationX = sum(abs(velocityChangeX)) ./ (dt);
    averageAccelerationY = sum(abs(velocityChangeY)) ./ (dt);
    averageAcceleration = sum(positionchange) ./ (dt);
    
    %Angular Velocity
    U = hex2dec(Tmp(2,:));
    V = hex2dec(Tmp(3,:));
    U = [U T];
    V = [V T];
    [curlz,cav]= curl(U,V);
    avrAngVX = mean(cav(:,1));
    avrAngVY = mean(cav(:,2));
    %Angular Acceleration
    angularAccelertionChangeX = diff(cav(:,1));
    angularAccelertionChangeY = diff(cav(:,2));
    averageAngularAccelerationx = sum(abs(angularAccelertionChangeX)) ./ (dt);
    averageAngularAccelerationY = sum(abs(angularAccelertionChangeY)) ./ (dt);
    

%     FeatureVector = [begTime endTime xMean yMean MMean mMean xMax yMax MMax mMax xMin yMin MMin mMin relocationX relocationY distanceX distanceY distance averagespeedx averagespeedy averagespeed]
%     FeatureVector = [xMean yMean MMean mMean pressureMean xMax yMax MMax mMax pressureMax xMin yMin MMin mMin pressureMin relocationX relocationY distanceX distanceY distance averagespeedx averagespeedy averagespeed averageAccelerationX averageAccelerationY averageAcceleration];
%     FeatureVector = [xMean yMean MMean pressureMean xMax yMax MMax pressureMax xMin yMin MMin pressureMin relocationX relocationY distanceX distanceY distance averagespeedx averagespeedy averagespeed averageAccelerationX averageAccelerationY averageAcceleration];
%     FeatureVector = [xMean yMean MMean xMax yMax MMax xMin yMin MMin relocationX relocationY distanceX distanceY distance averagespeedx averagespeedy averagespeed averageAccelerationX averageAccelerationY averageAcceleration];
    %Ang Vl and Acc
    FeatureVector = [xMean yMean MMean xMax yMax MMax xMin yMin MMin relocationX relocationY distanceX distanceY distance averagespeedx averagespeedy averagespeed averageAccelerationX averageAccelerationY averageAcceleration avrAngVX avrAngVY averageAngularAccelerationx averageAngularAccelerationY ];
%     disp(size(FeatureVector));
 end