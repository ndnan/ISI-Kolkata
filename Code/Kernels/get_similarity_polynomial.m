function similarity = get_similarity_polynomial(x1, x2, k)
    similarity = (1 + (x2 * x1')).^k;
end