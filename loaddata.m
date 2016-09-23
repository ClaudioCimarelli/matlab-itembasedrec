
%% loading data
% movielen1m contains two subsets: train_vec and test_vec
% train_vec and test_vec are in a triplet form: user_id item_id rating
% train_vec is used for training, and test_vec is used to testing

load movielen1m
num_m = 3952; % number of movies in the data set
num_p = 6040; % number of users in the data set

% form a num_m X num_p 2-D matrix for training
train_data = sparse(train_vec(:,2),train_vec(:,1),train_vec(:,3),num_m,num_p); 
% form a num_m X num_p 2-D matrix for testing
test_data = sparse(test_vec(:,2),test_vec(:,1),test_vec(:,3),num_m,num_p);

% tranform sparse matrix to density data set
train_data=full(train_data);
test_data=full(test_data);

%% basic information of data sets
% global mean of all ratings
g_avg = mean(train_vec(:,3));
% mean rating of each movie
mean_p = sum(train_data,2)./ sum(train_data~=0, 2);
mean_p(isnan(mean_p)) = g_avg;

% binary the training matrix as mask
train_msk = train_data;
train_msk(train_msk>0)=1;
train_num = length(train_vec);

% binary the testing matrix as mask
test_msk = test_data;
test_msk(test_msk>0)=1;
test_num = length(test_vec);

max_r = max(train_vec(:,3)); % max rating in traing set
min_r = min(train_vec(:,3)); % min rating in training set
clear train_vec test_vec
