function J = correlation_criterion(Ak, features, classes)
    %This function computues the criterion value for given Ak indices in
    %features.
    %Here we seperately compute numerator and denominator and divide it to
    %get J.
    
    numerator = 0;
    denominator = 0;
    N = length(classes);
    M = length(Ak);
    
    
    %Below code snippet is used to compute the denominator part of the J
    %That is, this deals with similarity between two features
    for i = 1:M
        for j = i:M
            num_feature = 0;
            den_feature_temp1 = 0;
            den_feature_temp2 = 0;
            for k = 1:N
                num_feature = num_feature + (features(k, Ak(i)) * features(k, Ak(j)));
                den_feature_temp1 = den_feature_temp1 + (features(k, Ak(i))^2);
                den_feature_temp2 = den_feature_temp2 + (features(k, Ak(j))^2);
            end
            den_feature = sqrt(den_feature_temp1 * den_feature_temp2);
            correlation_i_j = num_feature / den_feature;
            denominator = denominator + correlation_i_j;
        end
    end
    
    
    
    %Below code snippet is used to compute the numerator part of the J
    %That is this deals with the similarity between a feature vectoe and a
    %class
    for i = 1:M
        num_class = 0;
        den_class_temp1 = 0;
        den_class_temp2 = 0;
        for j = 1:N
            num_class = num_class + (features(j, Ak(i)) * classes(j));
            den_class_temp1 = den_class_temp1 + (features(j, Ak(i))^2);
            den_class_temp2 = den_class_temp2 + (classes(j)^2);
        end
        den_class = sqrt(den_class_temp1 * den_class_temp2);
        correlation_i_c = num_class / den_class;
        numerator = numerator + correlation_i_c;
    end    
    
    %If the set of indices is empty then J is returned as 0
    %Else division operation is performed.
    if isempty(Ak)
        J = 0;
    else
        J = numerator / denominator;
    end
    