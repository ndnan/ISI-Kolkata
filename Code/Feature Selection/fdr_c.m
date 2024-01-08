function FDR=fdr_c(ind, X, y) 
    %getting what classes are there in the dataset
    the_classes=unique(y);
    %Getting how many classes are there
    class_length = length(the_classes);
    %Creating variance and mean vectors
    vari = zeros(class_length, 1);
    meani = zeros(class_length, 1);
    for i=1:class_length
        t_y=(y==the_classes(i));
        t_X=X(t_y, ind);
        meani(i)=sum(mean(t_X, 1));
        vari(i)=sum(var(t_X, 1));
    end
    %getting combinations. This generates all possible combinations of i j
    %but i != j
    combi=nchoosek(1:class_length,2);
    %Computing mean/variance
    final_vec=(meani(combi(:,1))-meani(combi(:,2))).^ 2 ./ (vari(combi(:,1))+vari(combi(:,2)))'; 
    FDR=sum(final_vec);
end