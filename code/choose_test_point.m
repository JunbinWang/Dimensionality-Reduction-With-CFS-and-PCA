% This function is used to chooose the threshold point for a specify
% attribute by compare the garins of entropy. The point which can
% produce maximum gain will be choosed as the threshold point of this
% attribute.
function [point, entropy] = choose_test_point(root_entropy, divide_points, temp_data)

    point_count = length(divide_points);
    sample_count = length(temp_data);
    
    entropy_gain_arr = zeros(point_count,1);
    entropy_arr = zeros(point_count,1);
   
    for i = 1 : point_count
        left_set = temp_data(temp_data(:,1) <= divide_points(i), :);
        right_set = temp_data(temp_data(:,1) > divide_points(i), :);
        
        left_entropy = calculate_entropy(left_set(:,2));
        right_entropy = calculate_entropy(right_set(:,2));
        
        p_l = length(left_set) / sample_count;
        p_r = length(right_set) / sample_count;
        
        entropy_arr(i) = p_l * left_entropy + p_r * right_entropy;
        entropy_gain_arr(i) = root_entropy - p_l * left_entropy - p_r * right_entropy;
    end
    
    [~, max_index] = max(entropy_gain_arr);
    
    point = divide_points(max_index);
    entropy = entropy_arr(max_index);
end