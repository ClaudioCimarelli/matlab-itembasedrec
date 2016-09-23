function [ pccsim , mean] = calculate_pcc( train_data, train_msk )
% 1. You can find information about Pearson correlation here:
%    https://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient
% 2. Try to avoid using "for" loop
% 3. If you like, you can decide which paramemeters pass
%    through the function.

% para desc:
%    train_data - data used for training
%    train_msk - binarization of train_data
%    pccsim - pearson correlation

C = train_data.';
CM = train_msk.';

fun = @(A,B) A.'*B; 
fun2 = @(A,B) A.'.*B; 

N = bsxfun(fun,CM,CM);%%number of user that rated item ij
M1 = bsxfun(fun,C,CM);%cumulative sum of ratings on ij
M = bsxfun(@rdivide, M1,N);%% mean of rating for every item ij
M(~isfinite(M))=0;
MM = bsxfun(fun2,M,M);% product of the mean

%calculate covariance matrix
I = bsxfun(fun,C,C); 
COV=bsxfun(@minus, bsxfun(@rdivide,I,N) , MM);
COV(~isfinite(COV))=0;

% S = bsxfun(@minus, C, M);
% S = sqrt(mean(S.^2));
% S = bsxfun(fun, S, S);

%calculate st deviation from covariance
VAR = diag(COV);
STD = bsxfun(@power, VAR, 1/2);
STD2 = bsxfun(@times, STD.',STD);

% %st deviation from straight formula
% X = bsxfun(@power,C,2);
% X = bsxfun(@rdivide, sum(X), sum(CM));
% mean = diag(M);
% mean = bsxfun(@power, mean(:), 2);
% STDb = bsxfun(@power, bsxfun(@minus, X.', mean), 1/2);
% STDb(~isfinite(STDb))=0;
% STD2b = bsxfun(@times, STDb.',STDb);

%PEARSON
P = bsxfun(@rdivide,COV,STD2);
P(~isfinite(P))=0;

%%TESTS
%  A= C(:,1);
%  B=C(:,2);
% goodData = A~=0 & B~=0; %# true wherever there's data for both A and B
% cor = corrcoef(A(goodData),B(goodData))
% t = toc
% train_data(train_data==0)=NaN;
% RHO = cov(train_data(:,1:20),'rows','pairwise');%test

 pccsim = P;
 mean = M;
% 
% end


