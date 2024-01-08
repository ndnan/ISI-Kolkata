function [dist_vector] = get_epsilon(k, data)
    [M, ~] = size(data);
    dist_vector = zeros(M, 1);
    for i=1:M
        test_instance = data(i, :);
        [euc_dist, ~] = sort(sqrt(sum((data - test_instance) .^ 2, 2)));
%       k+1 because it is calculating euclidean distance with itself which
%       is zero
        dist_vector(i) = sum(euc_dist(1:k+1))/k;
    end
end