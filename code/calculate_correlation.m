% This function is used to calculate Pearson Correlation Coefficient
% between two features or between feature and target set. 
function r = calculate_correlation(x, y)

    l = length(x);
    
    avg_x = mean(x);
    avg_y = mean(y);
    
    tmp_sum = zeros(3,1);
    
    for i = 1 : l
        diff_x = x(i) - avg_x;
        diff_y = y(i) - avg_y;
        
        tmp_sum(1) = tmp_sum(1) + diff_x * diff_y;
        tmp_sum(2) = tmp_sum(2) + diff_x * diff_x;
        tmp_sum(3) = tmp_sum(3) + diff_y * diff_y;
    end
    
    % Return absolute value of the result
    r = abs(tmp_sum(1) / (sqrt(tmp_sum(2)) * sqrt(tmp_sum(3))));
        
end
