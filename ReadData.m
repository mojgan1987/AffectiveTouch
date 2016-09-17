clear all
myfile = fopen('joao2.txt','r');
%40  = 2*num of lines!
Intro = textscan(myfile,'%s',48,'Delimiter','\n');
disp(Intro{1});

% Reading file
moj = textscan(myfile, '%s %s %s %s %s %s %s');
% Removing last ]
testi = moj{2}(1:end);
data = testi;
data=cellfun(@(x) x(1:end-1),data,'UniformOutput',false);
moj{2}(1:end) = data;
final_cell = [moj{2} moj{3} moj{4} moj{5} moj{6}];

% Separating Touches
IndexDOwn = strfind(final_cell,'DOWN');
IndexUP = strfind(final_cell,'UP');


% Creating new matrix
% new_mat = zeros();
new_mat(1,1) = str2num(final_cell{1,1});
new_mat(1,2) = hex2dec(final_cell{2,5});
new_mat(1,3) = hex2dec(final_cell{3,5});
new_mat(1,4) = hex2dec(final_cell{4,5});
new_mat(1,5) = 2;
% i = 5;
j = 1;
[r, c] = size(final_cell);
touch_no = 2;
for i = 6:r
    dbstop if condition
    if ~(strcmp(final_cell{i,1},final_cell{i-1,1}))
        j = j + 1;
        new_mat(j,1) = str2num(final_cell{i,1});
        ev_info = final_cell{i,4};
        switch ev_info
            case {'ABS_MT_POSITION_X'}
                new_mat(j,2) = hex2dec(final_cell{i,5});
            case {'ABS_MT_POSITION_Y'}
                new_mat(j,3) = hex2dec(final_cell{i,5});
            case {'ABS_MT_TOUCH_MAJOR'}
                new_mat(j,4) = hex2dec(final_cell{i,5});  
            case {'ABS_MT_WIDTH_MAJOR'}
                new_mat(j,5) = hex2dec(final_cell{i,5});  
            case {'ABS_MT_TRACKING_ID'}
                touch_no = touch_no+1;
                new_mat(j,6) = touch_no;  
                j = j-1;
            otherwise
                continue
        end
    else
        ev_info = final_cell{i,4};
        switch ev_info
            case {'ABS_MT_POSITION_X'}
                new_mat(j,2) = hex2dec(final_cell{i,5});
            case {'ABS_MT_POSITION_Y'}
                new_mat(j,3) = hex2dec(final_cell{i,5});
            case {'ABS_MT_PRESSURE'}
                new_mat(j,4) = hex2dec(final_cell{i,5});  
            case {'ABS_MT_TRACKING_ID'}
%                 touch_no = touch_no+1;
%                 new_mat(j,5) = touch_no;  
            otherwise
                continue
        end
    end
end

[r_z, c_z] = find(new_mat==0);
z_ind  = [r_z c_z];

for cnt = 1: size(z_ind,1)
    new_mat(r_z(cnt),c_z(cnt)) = new_mat(r_z(cnt)-1,c_z(cnt));
end

% Refining the matrix
new_mat(:,5) = new_mat(:,5)/2;
new_mat(end,:) = [];

%% Feature extraction
% 1. number of touches
Features = new_mat(end, end);

% Calculate for each touch
Dx = zeros(1, new_mat(end, end));
Dy = zeros(1, new_mat(end, end));
Dt = zeros(1, new_mat(end, end));
Vx = zeros(1, new_mat(end, end));
Vy = zeros(1, new_mat(end, end));
Relocation = zeros(1, new_mat(end, end));
Averagespeedx  = zeros(1, new_mat(end, end));
Averagespeedy  = zeros(1, new_mat(end, end));
Averagespeed  = zeros(1, new_mat(end, end));
Pressure = zeros(1, new_mat(end, end));
for id = 1:new_mat(end, end)
    ind = find(new_mat(:,5) == id);
    [ri, ci] = size(ind);
    if(ri==0)
        continue;
    end
    x1 = new_mat(min(ind), 2);
    x2 = new_mat(max(ind), 2);
    y1 = new_mat(min(ind), 3);
    y2 = new_mat(max(ind), 3);
    t1 = new_mat(min(ind), 1);
    t2 = new_mat(max(ind), 1);
    
    dx = (x2-x1);
    dy = (y2-y1);
    dt = (t2-t1);
    relocation = sqrt(dx^2+dy^2);
    vx = dx/dt;
    vy = dy/dt;
    v = sqrt(vx^2+vy^2);
    
    positionchangex = diff(new_mat(min(ind):max(ind), 2));
    positionchangey = diff(new_mat(min(ind):max(ind), 3));
    timechange = diff(new_mat(min(ind):max(ind), 1));
    positionchange = ((positionchangex .^ 2) + (positionchangey .^ 2)) .^ 0.5;
    
    averagespeedx = sum(abs(positionchangex)) ./ (dt);
    averagespeedy = sum(abs(positionchangey)) ./ (dt);
    averagespeed = sum(positionchange) ./ (dt);
%     momentalspeedx = 

    
    Dx(1,id) = dx;
    Dy(1,id) = dy;
    Dt(1,id) = dt;
    Vx(1,id) = vx;
    Vy(1,id) = vy;
    V(1,id) = v;
    Relocation(1,id) = relocation;
    Averagespeedx(1, id) = averagespeedx;
    Averagespeedy(1, id) = averagespeedy;
    Averagespeed(1, id) = averagespeed;
    
    % Pressure
    Pressure(1, id) = mean(new_mat(min(ind):max(ind), 4));

end
Dx = abs(Dx);
Dy = abs(Dy);

% removing zeros
Relocation(Relocation==0) = [];
Pressure(Pressure==0) = [];

% 2. dx, dy, abs(dx), abs(dy), relocation
% Features = [Features, min(Dx), max(Dx), mean(Dx), std(Dx), min(Dy), max(Dy), mean(Dy), std(Dy), min(Relocation), max(Relocation), mean(Relocation), std(Relocation), min(Pressure), max(Pressure), mean(Pressure), std(Pressure)];
Features = [min(Relocation), max(Relocation), mean(Relocation), std(Relocation), min(Pressure), max(Pressure), mean(Pressure), std(Pressure)];


%% Nothing!
% % Reading time
% format shortE
% time_stamp = str2num(cell2mat(data));
% 
% % while ~feof(myfile)    
% %     fline = fgetl(myfile);
% % end
