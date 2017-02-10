% This function is used to divide sample data into left subset and right
% subset according to the current best feature and its threshold.
function [left_subset,left_labels,right_subset,right_labels] = divide_by_feature(best_feature, best_thread, raw_examples, raw_labels)

    left_index = raw_examples(:, best_feature) <= best_thread;
    right_index = raw_examples(:, best_feature) > best_thread;
    
    left_subset = raw_examples(left_index, :);
    left_labels = raw_labels(left_index, 1);
    
    right_subset = raw_examples(right_index, :);
    right_labels = raw_labels(right_index, 1);
    
    % Mark the best feature as NaN so that we can ignore it during recursion process. 
    left_subset(:, best_feature) = NaN;
    right_subset(:, best_feature) = NaN;
    
end