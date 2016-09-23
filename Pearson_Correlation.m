function[c] = Pearson_Correlation(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Computes the Pearson Correlation between vectors x and y
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
meanx = mean(x);
meany = mean(y);
sigx = std(x);
sigy = std(y);
sum = 0;
n = length(x);
for i = 1:n
    sum = sum+x(i)*y(i);
end
c = (sum-n*meanx*meany)/((n-1)*sigx*sigy);
return;