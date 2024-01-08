function [y_g,c,DB, Dunn]=kMeansCluster(m,k,isRand)
 
if nargin<2
    k=2;
end
 
if nargin<3
    isRand=1;
end
 
[maxRow, maxCol]=size(m);
 
if maxRow<=k
    y=[m, 1:maxRow];
else
    if isRand
        p = randperm(size(m,1));      % random initialization
        for i=1:k
            c(i,:)=m(p(i),:);  
        end
    else
        for i=1:k
           c(i,:)=m(i,:);        % sequential initialization
        end
    end
    
    temp=zeros(maxRow,1);   % initialize as zero vector
    
    while 1
        d=DistMatrix(m,c);  % calculate objcets-centroid distances
        [~,g]=min(d,[],2);  % find group matrix g
        if g==temp
            break;          % stop the iteration
        else
            temp=g;         % copy group matrix to temporary variable
        end
        
        for i=1:k
            c(i,:)=mean(m(g==i,:));
        end
    end
    a = 1:k;
    a = reshape(a, [k, 1]);
    T_matrix = [a,histc(g(:),a)] ;
    y_g=[m,g];

% DB index
% Below is the code to find the indices of the training set assigned to a
% perticular cluster
dict = containers.Map('KeyType','double', 'ValueType','any');
end

for i=1:k
    dict(i) = [];
end    
   
for i=1:length(g)
%     A = cell2mat(keys(dict));
%     if ((isempty(keys(dict))) || sum(find(g(i)==A))==0)
%         dict(g(i)) = i ;
%     else
        temp=dict(g(i));
        temp=[temp , i];
        dict(g(i))=temp;
%     end
end

%Below is the code to find S, here stored in sum1 variable
 
sum1 = zeros(1, k);
for i = 1:k
   t_sum1 = 0;
   y = dict(i);
   for j=1:length(y)
       X = m(y(j), :);
       A = c(i, :);
       t_sum1 = t_sum1 + (sum((X - A).^2));
   end
   t_sum1 = t_sum1 ./ T_matrix(i, 2);
   t_sum1 = (t_sum1).^(1/2);
   sum1(1, i) = t_sum1;
end
 
 
 
%Below is the code to find M
M = containers.Map('KeyType','char', 'ValueType','any');

for i=1:k
    for j=1:k
        str = strcat(int2str(i), int2str(j));
        M(str) = 0;
    end    
end

for i=1:k
    A = c(i, :);
    for j=1:k
        if i == j
            continue
        end
        str = strcat(int2str(i), int2str(j));
        temp_a = cell2mat(keys(M));
        if (isempty(keys(M))) || (sum(strmatch(str, temp_a)) == 0)
            M(str) = 0;
        end
        B = c(j, :);
        temp_m = M(str);
        temp_m = temp_m + (sum((A - B).^2));
        M(str) = temp_m;
    end
end
 
k1 = keys(M);
for i=1:length(M)
    str = cell2mat(k1(i));
    temp_dict = M(str);
    temp_dict = temp_dict^(1/2);
    M(str) = temp_dict;
end
 
%Below is the code to calculate R
R = containers.Map('KeyType','char', 'ValueType','any');
D = zeros(1, k);
for i=1:k
    si = sum1(1, i);
    t_vec = zeros(1, k);
    for j=1:k
        if i==j
            continue
        end
        str = strcat(int2str(i), int2str(j));
        temp_a = cell2mat(keys(R));
        if (isempty(keys(R))) || (sum(strmatch(str, temp_a)) == 0)
            R(str) = zeros(1, maxCol);
        end
        sj = sum1(1, i);
        t_sum_R = si + sj;
        
        R(str) = t_sum_R / M(str);
        t_vec(1, i) = R(str);
    end
    D(1, i) = max(t_vec);
end
DB = sum(D)/k;
 
%Dunn index
a = cell2mat(values(M));
numerator_Dunn = min(a(a~=0));
denominator_Dunn = max(sum1);
Dunn = numerator_Dunn/denominator_Dunn;
 
end

