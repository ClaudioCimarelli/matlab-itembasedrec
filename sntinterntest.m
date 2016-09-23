%% testing on computer for intern
% task description: a complete testing of mean-centering item-basd neighborhood method 

%  1. Loading movielen-1m data set which is a real movie-ratings data sets
%     provided movielens. It's done, you dont need to do this, please 
%     read the introduction in loaddata.m for more detail
%  2. Using pearson correlation as similarity between items, completing
%     function calculate_pcc
%  3. Implementing mean-centering item-basd neighborhood method, completing
%     function fit_data
%  4. Accuracy evaluation under RMSE, completing function evaluate_rmse

%% requirements:
% considering different test-bed (your computer), we give a lowest requirements
%   for your implementation: rmse_val < 0.9 && time_cost < 20 seconds. 

%% remark
% We provide you a test framework written by Matlab. If you dont want to use
% matlab you can also use Python, but you need to write assistant functions by
% yourself. 
% For python user: The original data set, ratings.dat, is attached. You can read
% the data by Python easily. 90% is divided for training set and 10% for testing
% set.

% !!! Your future job is mainly based on Matlab or Python, so please dont
% choose other languages for implementation.

% If you don't have Matlab in your computer, you can use HPC of UL. And we
% encourage you using HPC. Please find the tutorial at: https://hpc.uni.lu/

% If you are not familiar with matlab, you can also choose Python, and
% always try to avoid using "for" loop. numpy is suggested.

% You are allowed to use Google. 
% Four days for you to complete this task, including learning how to use
% Matlab/Python/HPC in case you need. 

%% working space

clear;
fprintf(1, 'Loading data set...\n');
loaddata;

tic
fprintf(1, 'Calculating Pearson coefficent correlations (PCC)...\n');
%% TODO: completing function calculate_pcc, more detail is in calculate_pcc
[pccsim, mean_item] = calculate_pcc(train_data, train_msk);

fprintf(1, 'Fitting (predicting)...\n');
%% TODO: completing function fit_data, more detail is in fit_data
pred_out = fit_data(train_data, train_msk, test_msk, pccsim, mean_item);

fprintf(1, 'Evaluating...\n');
%% TODO: completing function evaluate_rmse, more detail is in evaluate_rmse
rmse_val = evaluate_rmse(pred_out, test_data, test_msk, test_num);

fprintf(1, 'RMSE value is %6.4f \n', rmse_val);

t=toc

if rmse_val<0.9
    fprintf(1, 'PASS: RMSE value is %6.4f \n', rmse_val);
else
    fprintf(1, 'FAILED: RMSE value should not be greater than 0.9! \n');
end


if t<20
    fprintf(1, 'PASS: Time cost %6.4f seconds. \n', t);
else
    fprintf(1, 'FAILED: Time cost should not be more than 20 seconds! \n');
end




