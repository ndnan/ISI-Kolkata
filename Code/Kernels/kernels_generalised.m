function new_features = kernels_generalised(features, degree)
    [M, N] = size(features);

    %choosing landmarks
    %If number of new features is not mentioned then number of new features
    % is same as the number of instances

    reqd_cols = M;
    landmark = zeros(reqd_cols, N);
    lnd_idx = randperm(reqd_cols);
    for i=1:reqd_cols
        landmark(i, :) = features(lnd_idx(i), :);
    end
    
    %If degree is mentioned
    if nargin == 2
        kernel_features = get_similarity_polynomial(landmark, features, degree);
        string = strcat(int2str(degree), 'polynomial.mat');
    else
        kernel_features = get_similarity_gaussian(landmark, features);
        string = 'gaussian_100sig.mat';
    end    
    new_features = kernel_features;
    new_kernel_mat = strcat(strcat('Arrhythmia_', int2str(reqd_cols)), strcat('d_', string));
    save(new_kernel_mat, 'new_features');
end