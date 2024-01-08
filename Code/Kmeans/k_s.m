function [y_g,c,DB, Dunn] = k_s(m,n)

 c = zeros(n-1, size(m, 2));
 DB = zeros(1, n-1);
 Dunn = zeros(1, n-1);
 for i = 2 : n
     [y_g,c,DB(1, i-1), Dunn(1, i-1)] = kMeansCluster(m,i) ;
 end
 
end
