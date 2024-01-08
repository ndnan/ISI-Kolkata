function [indices, selected_features] = preprocess_and_return_indices(file_name, l, indx)

    %This works for every dataset which contains first column as classes
    %and rest of them as features
    
    %This function returns the indices of the selected best features
    %This function accepts the file name and required optimal features as
    %input arguments
    
    dataset = csvread(file_name);
    
    %features and classes are extracted from the dataset
    classes = dataset(:, 1);
    [~, N] = size(dataset);
    features = dataset(:, 2:N);
    
    %The extracted features are normalised
    %features = normalize(features);
    indices = sfs(l, features, classes, indx);
    %indices = sbs(l, features, classes);
    %indices = plus_l_minus_r(L, R, features, classes);
    selected_features = choose_features(file_name, indices);
    select_mat_name = strcat('Internet_Ads_', int2str(l), 'd_FeatureSelection.mat');
    save(select_mat_name, 'selected_features', 'indices');