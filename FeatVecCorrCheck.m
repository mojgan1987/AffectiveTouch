%Correlation checking
[r, c] = size(FeatureVector);
RHO = zeros(c*(c-1)/2,2);
PVAL = zeros(c*(c-1)/2,2);
tp = 0;
for i = 1 : c
    for j = i+1 : c
        tp = tp+1;
        X = FeatureVector(:,i);
        Y = FeatureVector(:,j);
        [RHOm,PVALm] = corrcoef(X,Y);
        RHO(tp,1:2) = [i, j];
        RHO(tp,4:5) = [RHOm(1,2), RHOm(2,1)];
%         PVAL(i,1:3) = strcat(int2str(i), int2str(j));
%         PVAL(i,4:5) = [PVALm(1,2), PVALm(2,1)];
    end
end