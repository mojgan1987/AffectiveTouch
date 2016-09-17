length = 1760;
timeholder = zeros(length,1);
for i=1:length-1
%     timeholder(i) = 39.006 + (i-1)*0.066;
%     timeholder(i+1) = timeholder(i)+0.066;
     timeholder(i+1) = timeholder(i)+0.0625;
%%     timeholder(i+1) = timeholder(i)+0.1;
end
% 
% 
% for lll = 1:67
%     if(ar(lll,1)<0.24)
%        ar(lll,2) = 1;
%     else
%         if(ar(lll,1)<0.30)
%             ar(lll,2) = 2;
%         else
%             if(ar(lll,1)<0.36)
%                 ar(lll,2) = 3;
%             else
%                 ar(lll,2) = 4;
%             end
%         end
%     end
% end
% 
% for lll = 1:67
%     if(ar(lll,1)<0.25)
%        ar(lll,2) = 1;
%     else
%        ar(lll,2) = 2;
%     end
% end