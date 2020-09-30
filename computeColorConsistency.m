function f2 = computeColorConsistency(refY)

f = imhist(refY);
histY = f'/sum(f);
    
f2(1) = mean(double(refY)/255); %mean
f2(2) = std(double(refY)/255); %std
f2(3) = median(double(refY)/255); %median
f2(4) = mode(double(refY)/255);

f2(5) = -sum(histY.*log2(histY+ 0.000001), 'all'); %entropy

f2(6) = sum(histY.^2);
f2(7) = sum(histY ~= 0)/256;

end
