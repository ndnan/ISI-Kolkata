function [ptsC, noise] = preprocess(k, file_name)
    data = csvread(file_name);
    [M, ~] = size(data);
%   data = normalize(data);
    
    dist_vector = get_epsilon(k, data);
    x = (1:M)';
    y = sort(dist_vector);
    plot(x, y);
    
    slope = zeros(length(y)-1, 1);
    
    for i=1:length(y)-1
        slope(i) = (y(i+1)-y(i))/(x(i+1)-x(i));
    end
    slope2 = zeros(length(slope)-1, 1);
    for i=1:length(slope)-1
        slope2(i)=slope(i+1)-slope(i);
    end
    
    [~, idx] = sort(slope2, 'descend');
    
    y_s = y(idx);
    epsilon = y_s(1:11);
    epsilon = sort(epsilon);
    prev_epsilon = epsilon(1);
    epsilon = epsilon(2:11);
    
    ptsC = zeros(M, length(epsilon));
    noise = zeros(M, length(epsilon));
    
    for i=1:length(epsilon)
        disp('-------------------------------------------------------------------------------------------------');
        min_point = find_min_points(prev_epsilon, epsilon(i), data);
        disp(prev_epsilon);
        disp(epsilon(i));
        disp(round(min_point));
        [ptsC(:, i), noise(:, i)] = dbs(data, epsilon(i), round(min_point));
        prev_epsilon = epsilon(i);
        disp('-------------------------------------------------------------------------------------------------');
    end
end