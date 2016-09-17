% for lll = 1:66
%     if(ar(lll,1)<0.37)
%        ar(lll,2) = 1;
%     else
%         if(ar(lll,1)<0.44)
%             ar(lll,2) = 2;
%         else
%             ar(lll,2) = 3;
%         end
%     end
% end

% for lll = 1:1390
%     if(ar(lll,1)>0)
%        ar(lll,2) = 1;
%     else
%        ar(lll,2) = -1;
%     end
% end
[a,b] = size(ar);
label = zeros(a,1);
for i=1:a
    if(ar(i)<=-0.5291)
        label(i,1) = 1;
    elseif(ar(i)<=-0.3417)
        label(i,1) = 2;
    elseif(ar(i)<=--0.1543)
        label(i,1) = 3;
    elseif(ar(i)<=  0.0331)
        label(i,1) = 4;
    elseif(ar(i)<=  0.2205)
        label(i,1) = 5;
    elseif(ar(i)<=  0.4079)
        label(i,1) = 6;
    elseif(ar(i)<=  0.5953)
        label(i,1) = 7;
    elseif(ar(i)<=  0.7827)
        label(i,1) = 8;
    else
        label(i,1) = 0;
    end        
end


% for lll = 1:68
%     if(ar(lll,1)<0.3326)
%        ar(lll,2) = 1;
%     else
%             ar(lll,2) = 2;
%     end
% end