[r c] = size(tmpFR);


for i = 1 : r
    if(rem(i,3) ~= 0)
        newFR(i,:) = tmpFR(i,:);
    end
end

data = newFR;
data( ~any(data,2), : ) = [];