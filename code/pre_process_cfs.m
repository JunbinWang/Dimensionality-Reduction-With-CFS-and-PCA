% This function is used to select features which has strong corrections with the
% whole dataset from original dataset by using CFS algorithm.
function [selected_features, binary_labels, sub_features_index] = pre_process_cfs(raw_samples, raw_labels, target_label)

    %Set the binary label value to 1 if it is the same as target label,otherwise set it to 0
    selected_features = raw_samples;
    binary_labels = (raw_labels == target_label);
    [~, feature_count] = size(raw_samples);
    % invoke the cfs function the select features and return their index.
    sub_features_index = cfs_feature_selection(raw_samples, binary_labels);
    % set dataset of features which are not seleced to NaN value so they will not
    % be considerd during building decision tree process.
    selected_features(:, setdiff(1:feature_count, sub_features_index)) = NaN; 
end