function features = choose_features(file_name, indices)
    %This file chooses the features which are in the indices
    [~, C] = size(indices);
    data = csvread(file_name);
    [M, N] = size(data);
    features = zeros(M, C);
    
    k=0;
    for i=1:N
        if (sum(find((i+1)==indices))~=0)
            k=k+1;
            features(:, k) = data(:, i+1);
        end
    end
end