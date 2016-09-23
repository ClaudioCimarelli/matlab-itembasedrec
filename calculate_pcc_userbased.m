function [ pccsim ] = calculate_pcc( train_data, train_msk )
% 1. You can find information about Pearson correlation here:
%    https://en.wikipedia.org/wiki/Pearson_product-moment_correlation_coefficient
% 2. Try to avoid using "for" loop
% 3. If you like, you can decide which paramemeters pass
%    through the function.

% para desc:
%    train_data - data used for training
%    train_msk - binarization of train_data
%    pccsim - pearson correlation




C = train_data;

fun = @(A,B) A.'*B; 
fun2 = @(A,B) A.'.*B; 


N = bsxfun(fun,train_msk,train_msk);%%number of pi itersec pj
M1 = bsxfun(fun,C,train_msk);%cumulative sum of ratings based on the pi pj intersec
M = bsxfun(@rdivide, M1,N);%% mean of rating for every user i when pi intersec pj
MM = bsxfun(fun2,M,M);% product of the mean

toc

%calculate covariance
I = bsxfun(fun,C,C); 
COV= bsxfun(@rdivide,I,N) - MM;

% S = bsxfun(@minus, C, M);
% S = sqrt(mean(S.^2));
% S = bsxfun(fun, S, S);
X = bsxfun(fun,(C.^2),train_msk);
STD = sqrt(bsxfun(@rdivide, X,N)-(M.^2));
STD2 = bsxfun(fun2, STD,STD);

%PEARSON
P = bsxfun(@rdivide,COV,STD2);

toc
%%TESTS
% A= C(:,1);
% B=C(:,2);
% goodData = A~=0 & B~=0; %# true wherever there's data for both A and B
% cor = corr(A(goodData),B(goodData));
% t = toc
%train_data(train_data==0)=NaN;
%RHO = corr(train_data(:,1:20),'rows','pairwise');%test

 pccsim = P;
% 
% end


