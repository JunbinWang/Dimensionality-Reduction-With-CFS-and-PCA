% This function is used to generate confusion matrix for decision trees
function confusion_matrix = test_all_tree(samples, samples_labels, trees)

    %obtain number of trees, samples 
    tree_count = length(trees);
    [sample_count, ~] = size(samples);
    result_matrix = zeros(sample_count, tree_count);
    
    % using every tree to generate a binary confusion matrix
    for i = 1 : tree_count
        
        for j = 1: sample_count
            result_matrix(j, i) = classify_by_tree(samples(j,:), trees{i});
        end
    
    end
    
   % obtain confusion matrix with 6 classification tree
   confusion_matrix = evaluate_matrix(result_matrix, samples_labels);
   
end

