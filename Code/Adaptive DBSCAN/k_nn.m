function [predict, per] = k_nn(k, train_features, train_classes, test_features, test_classes)
    [test_m, ~] = size(test_features);
    predict = zeros(test_m, 1);
    for i=1:test_m
        test_instance = test_features(i, :);
        [~, idx] = sort(sqrt(sum((train_features - test_instance).^2, 2)));
        temp_classes = train_classes(idx);
        predict(i) = mode(temp_classes(1:k));
    end
    per = sum(predict==test_classes)/test_m*100;
end