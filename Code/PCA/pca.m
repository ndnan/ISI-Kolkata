function Z_features = pca(features, k)
%     This is the code for PCA
%     First normalising the features
    X = normalise_pca(features);
    
%     The below implementation(which is commented) slows down the algorithm
%     Because if X is 5000 dimensional then Sigma would be of dimensions 5000 X 5000
%     Sigma = (X' * X)/size(X, 1);
%     [t_eigen_vectors, t_eigen_values] = eig(Sigma);
    
    % The below code exdtracts the eigen vectors and eigen values
    [~, t_eigen_values, t_eigen_vectors] = svd(X);
    
    %The below code is to sort eigenvectors based on eigenvalues
    [t_m, t_n] = size(t_eigen_vectors);
    eigen_vectors = zeros(t_m, t_n);
    eigen_values = abs(diag(t_eigen_values));
    [eigen_values, idx] = sort(eigen_values, 'descend');
    for i=1:length(idx)
        eigen_vectors(:, i) = t_eigen_vectors(:, idx(i));
    end
    % Sorting of eigen values completed
    
    % If k is not mentioned. We're taking k which captures 90% variance of the data
    if nargin < 2
        cumulative_eigen_values = cumsum(eigen_values);
        sum_eigen_values = sum(eigen_values);
        capture_percentage = (cumulative_eigen_values/sum_eigen_values) * 100;
        figure; stairs(cumulative_eigen_values/sum_eigen_values);
        k = find(capture_percentage>=90, 1);
    end
    
    Z = eigen_vectors(:, 1:k);
    Z_features = X * Z;
    new_mat_name = strcat(strcat('kdd_',int2str(k)),'d_pca.mat');
    save(new_mat_name, 'Z_features');
end