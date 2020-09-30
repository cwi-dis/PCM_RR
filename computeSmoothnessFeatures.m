function f4 = computeSmoothnessFeatures(ang_sim_mat)
k = 9;
N = 300;
% x = reshape(ang_sim_mat(:, 1:k), [],1);
x = mean(ang_sim_mat(:, 1:k), 2);
[Xval, ~] = histcounts(x, N);

histval = Xval'/sum(Xval);



f4(1) = mean(mean(ang_sim_mat(:, 1:k))); %mean
f4(2) = mean(std(ang_sim_mat(:, 1:k), [], 1)); %std
f4(3) = std(mean(ang_sim_mat(:, 1:k), 2));
% f4(3) = mean(mode(ang_sim_mat(:, 1:k), 1)); %mode
f4(4) = mean(median(ang_sim_mat(:, 1:k), 1)); %median
% f4(4) = std(mean(ang_sim_mat(:, 1:k), 1));

% f4(4) = std(mean(ang_sim_mat(:, 1:6))); %std
% 
f4(5) = -sum(histval.*log2(histval+ 0.000001), 'all'); %entropy
f4(6) = sum(histval.^2);
f4(7) = sum(histval ~= 0)/size(histval, 1);
% f4(5) = sum(histval == 0); %sparsity

% f4(5) = [];
end