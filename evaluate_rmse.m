function [ rmse_val ] = evaluate_rmse( pred_out, test_data, test_msk, test_num )
% 1. You can find RMSE introduction here:
%    https://www.kaggle.com/wiki/RootMeanSquaredError
% 2. Try to avoid using "for" loop
% 3. If you like, you can decide which paramemeters pass
%    through the function.

% para desc:
%    test_data - data used for testing
%    test_msk - binarization of test_msk
%    test_num - number of user-item pair in test data set
%    pred_out - predication obtained from function fit_data
%    rmse_val - rmse value
S = bsxfun(@minus, test_data, pred_out);
S = S(S~=0);
S = bsxfun(@power, S(:), 2);
M = mean(S);
rmse_val = sqrt(M);
end

