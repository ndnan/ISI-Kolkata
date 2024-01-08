function similarity = get_similarity_gaussian(x1, x2)
    sigma = 100;
    [m_l, ~] = size(x1);
    [m_f, ~] = size(x2);
    similarity = zeros(m_f, m_l);
    
%     The below commented code is just for reference
%     But the same is achieved in a single for loop instead of two
%
%     for i=1:m_l
%         landmark = x1(i,:);
%         t_column = zeros(m_f, 1);
%         for j=1:m_f
%             temp = sum((x2(j, :) - landmark).^2);
%             t_column(j) = temp / (2*(sigma^2));
%         end    
%         similarity(:,i) = exp(-t_column);
%     end

    format short e;
    for i =1:m_l
        land = x1(i, :);
        temp = (x2 - land).^2;
        feat = (sum(temp, 2)/(2* (sigma^2)));
        similarity(:, i) = exp(-feat);
    end    
end