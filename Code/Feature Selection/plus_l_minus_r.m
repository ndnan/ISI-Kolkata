function Ak = plus_l_minus_r(L, R, features, classes)
    if L > R
        Ak = sfs(L, features, classes);
        
        for i = 1:R
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
    else
        Ak = sbs(R, features, classes);
        
        for i=1:L
            index = 0;
            maxJ = 0;
            for j=1:total_features
                if sum(find(j==Ak)) ~= 0
                    continue
                end
                t_indicies = Ak;
                t_indicies = union(t_indicies, j);
                %x2 = correlation_criterion(t_indicies, features, classes);
                x2 = fdr_criterion(t_indicies, features, classes);
                if x2 >= maxJ
                   maxJ = x2;
                   index = j;
                end
            end
            if index ~= 0
                Ak = union(Ak, index);
            end
        end
    end 