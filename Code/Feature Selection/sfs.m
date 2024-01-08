function Ak = sfs(l, features, classes, indx)
    %This function is accepts l, total number of required optimal features,
    %feature vectors and class vector

    %Ak will be the set containing indicies of the selected features
    if nargin == 4
        Ak = indx;
    else
        Ak = [];
    end
    
    %We will be passsing the selected indices Ak, set of features, and
    %the class vector
    [~, total_features] = size(features);
    for i=(length(Ak)+1):l
        disp(i);
        index = 0;
        maxJ = 0;
        for j=1:total_features
            if sum(find(j==Ak)) ~= 0
                continue
            end
            t_indicies = Ak;
            t_indicies = union(t_indicies, j);
            x2 = abs(fdr_c(t_indicies, features, classes));
            if x2 >= maxJ
               maxJ = x2;
               index = j;
            end
        end
        if index ~= 0
            Ak = union(Ak, index);
        end
    end
