function [ pred_out ] = fit_data( train_data, train_msk, test_msk, pccsim, mean_item )
% 1. You can use mean-cerntering item-based algoritm for prediction
%    more detail: http://link.springer.com/chapter/10.1007%2F978-0-387-85820-3_4#page-1
%                 Section: 4.3.11, Equation: (4.16)
% 2. For simplicity, when estimating a user's preference on an unrated items,
%    you can simply use all the items rated by the user as neighbors
% 3. Try to avoid using "for" loop
% 4. If you like, you can decide which paramemeters pass
%    through the function.
% para desc:
%    train_data - data used for training
%    train_msk - binarization of train_data
%    pccsim - pearson correlation obtrained from function calculate_pcc
%    pred_out - the prediction of users' preference on items

%PARAMS
k = length(pccsim(:,1)); %k- neighbors
pccsim(~isfinite(pccsim))=0;%Nan values and infinite as 0 correlation
M = diag(mean_item);
% [Kn, I] = sort(pccsim,'descend');
% %Kn = Kn(1:k, :);
% % I = I(1:k,:);
% % I = sort(I);
% %Kn(k+1:length(Kn(:,1)), :) = 0;
% [B, X] = sort(I);
% Kn = Kn(X);
Kn = pccsim;
KnS = abs(Kn);%bsxfun(@power, bsxfun(@power,Kn,2),1/2);
KnS = KnS.'*train_msk;
D = KnS.*test_msk;
%KnS = sum(KnS);
M1 = bsxfun(@times,train_msk , M);
N = Kn.'*bsxfun(@minus,train_data, M1);
N = N.*test_msk;
%u1 = test_msk(:,1);
%D = bsxfun(@times,test_msk , KnS);
ris = bsxfun(@rdivide, N , D);
M2 = bsxfun(@times,test_msk , M);
ris = bsxfun(@plus,ris, M2);
ris(isnan(ris))=0;

%simU = repmat(pccsim,length(train_data(1,:)));
pred_out = ris;

end
