
function ang_similarity = computeSmoothness_knn(PC, k)

% [coeff, score, latent] = pca(points, 'Algorithm', 'svd', 'Centered', Fit.center); 
% normal = coeff(:, 3)';

% sorted_points = unique(PC.Location, 'rows');
% sorted_map = zeros(size(sorted_points));
ang_similarity = zeros(PC.Count, k-1);
if isempty(PC.Normal)
    PC.Normal = pcnormals(PC, 9);
end

for i=1:PC.Count
    
     [idx, ~] = findNearestNeighbors(PC,PC.Location(i,:),k);
    
%     idx = pckNN(i,:);
    
    
    normals = PC.Normal(idx, :);
   
%     for j=2:size(idx,2)
    ang_similarity(i, :) = real((pi - 2*acos(abs(sum(normals(1,:).*normals(2:end, :),2))))/pi);
%     end
end

end