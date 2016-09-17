maxN = max(emotions);
minN = min(emotions);

[e_r, e_c] = size(emotions);
for i = 1 : e_r
    A = maxN- emotions(i,:);
    B = maxN - minN;
    emo_n(i,:) = (A) ./ (B);
end

