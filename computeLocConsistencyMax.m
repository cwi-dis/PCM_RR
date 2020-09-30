function f = computeLocConsistencyMax(PCs, xlim, ylim, zlim)
% 
vox_depth = round(max(max(xlim, ylim), zlim)) +1;

xloc = PCs.Location(:,1) - PCs.XLimits(1);
yloc = PCs.Location(:,2) - PCs.YLimits(1);
zloc = PCs.Location(:,3) - PCs.ZLimits(1);

[Xval, ~] = histcounts(xloc, vox_depth);
[Yval, ~] = histcounts(yloc, vox_depth);
[Zval, ~] = histcounts(zloc, vox_depth);

histX = Xval'/sum(Xval);

histY = Yval'/sum(Yval);

histZ = Zval'/sum(Zval);

f2(1, 1) = mean(double(xloc)/round(xlim)); %mean
f2(2, 1) = std(double(xloc)/round(xlim)); %std
f2(3, 1) = median(double(xloc)/round(xlim)); %median
f2(4, 1) = mode(double(xloc)/round(xlim)); %mode
f2(5, 1) = -sum(histX.*log2(histX+ 0.000001), 'all')/round(xlim); %entropy
f2(6, 1) = sum(histX.^2)/round(xlim); %energy
f2(7, 1) = sum(histX ~= 0)/round(xlim); %sparsity

f2(1, 2) = mean(double(yloc)/round(ylim)); %mean
f2(2, 2) = std(double(yloc)/round(ylim)); %std
f2(3, 2) = median(double(yloc)/round(ylim)); %median
f2(4, 2) = mode(double(yloc)/round(ylim)); %mode
f2(5, 2) = -sum(histY.*log2(histY+ 0.000001), 'all')/round(ylim); %entropy
f2(6, 2) = sum(histY.^2)/round(ylim); %energy
f2(7, 2) = sum(histY ~= 0)/round(ylim); %sparsity

f2(1, 3) = mean(double(zloc)/round(zlim)); %mean
f2(2, 3) = std(double(zloc)/round(zlim)); %std
f2(3, 3) = median(double(zloc)/round(zlim)); %median
f2(4, 3) = mode(double(zloc)/round(zlim)); %mode
f2(5, 3) = -sum(histZ.*log2(histZ+ 0.000001), 'all')/round(zlim); %entropy
f2(6, 3) = sum(histZ.^2)/round(zlim); %energy
f2(7 ,3) = sum(histZ ~= 0)/round(zlim); %sparsity

f = max(f2, [], 2);
end
