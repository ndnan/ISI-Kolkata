function min_points = find_min_points(previous_epsilon, epsilon, data)
    [M, ~] = size(data);
    Pi = 0;
    for i=1:M
        test_instance = data(i, :);
        [euc_dist, ~] = sort(sqrt(sum((data - test_instance) .^ 2, 2)));
%       -1 because it is calculating euclidean distance with itself which
%       is zero
        Pi = Pi + sum((euc_dist<epsilon & euc_dist>previous_epsilon));
    end
    min_points = Pi/M;
end