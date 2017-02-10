% This function is used to chooose the best attribute as the root node of
% current tree. The attribute which can produce maximum entropy gain will be choosed as the best attribute.
function [best_feature, best_threshold] = choose_attribute(raw_examples, binary_labels)

    [total_example_count, feature_index_count] = size(raw_examples);
    
    feature_point_arr = zeros(1, feature_index_count);
    feature_entropy_gain_arr = zeros(1, feature_index_count);
    
    % Get the entropy for the root node
    root_entropy = calculate_entropy(binary_labels);
    
    %choose the best fearture and their threshold by compare them.
    for i = 1: feature_index_count
        
        if(isnan(raw_examples(1,i)))
            feature_point_arr(i) = NaN;
            feature_entropy_gain_arr(i) = NaN;
            continue;
        end
        
        temp_example = sortrows([raw_examples(:,i),binary_labels],1);
        
        % We don't choose points which will divide sample data with the same 
        % label into different subset as our divide points, because
        % these points will definitely not increase the current entropy gain.
        % This proecess can increase the efficiency of our code.
        divide_points = [];
        for k = 1:(total_example_count-1)
            if (temp_example(k,2) ~= temp_example(k + 1,2))
                divide_points = [divide_points, (temp_example(k,1) + temp_example(k+1,1)) / 2];  
            end
        end
        
        [test_point, test_entropy] = choose_test_point(root_entropy, divide_points, temp_example);
        feature_point_arr(i) = test_point;
        feature_entropy_gain_arr(i) = root_entropy - test_entropy;     
    end
    
    [~, max_index] = max(feature_entropy_gain_arr);
    best_feature = max_index;
    best_threshold = feature_point_arr(max_index);
end