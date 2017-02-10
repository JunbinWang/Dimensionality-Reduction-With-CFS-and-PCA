% This function is used to handle output from all 6 trees based on different
% conditions. And then output 1 result label for each input sample to form the confusion matrix.
function confusion_matrix = evaluate_matrix(result_matrix, labels)

    confusion_matrix = zeros(6,6);
    count = length(result_matrix);
        
    for i = 1 : count
        
        possible_results = find(result_matrix(i,:) == 1);

        % If all 6 binary trees output 0 for this sample data, then randomly choose
        % one label from 6 labels as the label of input data
        if isempty(possible_results)
            predicted = unidrnd(6);
        end

        % If there are one or multiple binary trees output 1 as the result,
        % then randomly choose a label from them as the label of the input
        % sample
        if ~isempty(possible_results)
            n = length(possible_results);
            predicted = possible_results(unidrnd(n));
        end

        % Add our result label to the confusion matrix
          ground_truth = labels(i);
          confusion_matrix(ground_truth, predicted) = confusion_matrix(ground_truth, predicted) + 1;
    end
    
end