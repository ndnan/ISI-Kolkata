function Ak = sbs(l, features, classes)
    [~, M] = size(features);
    Ak = 1:M;
    for i = 1:(M-l)
        max_indices = [];
        maxJ = 0;
        for j = 1:length(Ak)
            t_indices = Ak;
            t_indices(j) = [];
            %J2 = correlation_criterion(t_indices, features, classes);
            J2 = fdr_criterion(t_indices, features, classes);
            if J2 >= maxJ
                maxJ = J2;
                max_indices = t_indices;
            end
        end
        if ~isempty(max_indices)
            Ak = max_indices;
        end
    end
    
    
    