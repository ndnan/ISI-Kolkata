function features = normalize(feat)
    %This function takes the feature vectors as inputs and normalizes it
    %and returns it back
    [M, N] = size(feat);
    features = [];
    
    for i=1:N
        temp = feat(:, i);
        mean_feat = mean(temp);
        denominator = (max(temp) - min(temp));
        %If denominator == 0 means max=min in that column means the whole
        %column contains same value. So I had removed all those features.
        if denominator == 0
            continue
        end
        for j=1:M
            numerator = (temp(j) - mean_feat);
            if (numerator==0 || denominator==0)
                temp(j) = 0;
            else
                temp(j) = numerator/denominator;
            end
        end
        features = [features, temp];
    end
    csvwrite('/Volumes/NagadarshanN/ISI-Kolkata/Project/Sample_Data/arrhythmia_test1.csv', features);
end    
    