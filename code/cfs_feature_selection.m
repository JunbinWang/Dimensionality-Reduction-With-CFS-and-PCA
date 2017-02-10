% This function is used to do CFS feature selection. 
function [subset] = cfs_feature_selection(sample, target)

    [~, f_count] = size(sample);
    
    % rcf_matrix is used to store all correlation values between classes
    % and features.
    rcf_matrix = zeros(f_count, 1);
    % rff_matrix is used to store all correlation values between features.
    rff_matrix = zeros(f_count, f_count);
    
    subset = [];
    
    rcf_sum = 0;
    rff_sum = 0;
    cfs_max = 0;
    
    % Calculate correlation between feature and target class 
    for i = 1 : f_count
        rcf_matrix(i) = calculate_correlation(sample(:, i), target);
    end
    
    for i = 1 : f_count
        for j = 1 : f_count
            % Calculate correlation between features.
            rff_matrix(i, j) = calculate_correlation(sample(:, i), sample(:, j));
        end
    end
    
    for k = 1 : f_count
        
        cfs_iter_r = zeros(f_count, 3);
        
        for f = 1 : f_count
            
            if isnan(rcf_matrix(f))
                cfs_iter_r(f, 3) = NaN;
                continue;
            end
            
            cfs_iter_r(f, 1) = rcf_sum + rcf_matrix(f);
            cfs_iter_r(f, 2)  = rff_sum + sum(rff_matrix(f, subset));
            cfs_iter_r(f, 3) = cfs_iter_r(f,1) / (sqrt( k + 2 * cfs_iter_r(f,2)));
        end
        
        % Get the index of feature which has the maximum CFS value
        [value, index] = max(cfs_iter_r(:,3));
        
        % Stop the for-loop when the CFS value start to decrease.
        if (value) < cfs_max
            break;
        end
        
        subset = [subset, index];
        
        % Set features which have been selected to NaN so that we will
        % ignore it in the following iteration.
        rcf_matrix(index) = NaN;
        
        rcf_sum = cfs_iter_r(index, 1);
        rff_sum = cfs_iter_r(index, 2);
        cfs_max = cfs_iter_r(index, 3);
    end
end
