function f = getFeatures(PC, ang_sim_mat, k)

if nargin < 2
    computeSimilarityFlag = 1;
    k = 9;
elseif isempty(ang_sim_mat)
    computeSimilarityFlag = 1;
    if nargin < 3
        k = 9;
    end
else
    computeSimilarityFlag = 0;
end

[refY,~,~]=rgb2yuv(PC.Color(:,1),PC.Color(:,2),PC.Color(:,3));

f1 = computeLocConsistencyMax(PC, PC.XLimits(2), PC.YLimits(2), PC.ZLimits(2));
f2 = computeColorConsistency(refY);

if computeSimilarityFlag
    ang_sim_mat = computeSmoothness_knn(PC, k+1);
end

f3 = computeSmoothnessFeatures(ang_sim_mat);

f = single([f1(:); f2(:); f3(:)]);
    
end