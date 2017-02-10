% This function is the main function that we use to traning and test the decision tree.
% It accept the sample data and sample labels as input and output the
% average confusion matrix, eval matrix and matrixs for each cross
% validation.

% This function uses CFS algorithm to reduce the Dimensionality of original
% dataser before doing decision tree learning. Besides, the time of runing
% the program is also recorded by the 'tic top' command

function [tree_confusion_matrix, tree_eval_matrix, cross_validation_matrix] = cross_validation_desicion_tree_cfs(example, target)

    % The number of cross
    k = 10;
    % The number of labels we want to classify
    emotion = 6;
    
    [sample_num, ~] = size(example);
    
    % Divide the data into k subsets, the variable 'group' stores the index of each subsets.
    group = generate_k_split(target, k, emotion);
    
    cross_validation_matrix = zeros(emotion, emotion, k);
    
    for i = 1 : k
        
        sprintf('Doing %d cross validation', i);
        
        valid_index = group{i};
        train_index = 1 : sample_num;
        
        % train sets (9/10 of samples)
        train_index = setdiff(train_index, valid_index);
        train_index = train_index(randperm(length(train_index)));
        
        % validate sets (1/10 of samples)
        valid_input = example(valid_index, :);
        valid_target = target(valid_index, :);
        
        train_input = example(train_index, :);
        train_target = target(train_index, :);
        
        trees = cell(1, emotion);
        
        % generate binary decision trees for all class
        for j = 1 : emotion
            % Apply CFS after spliting dataset into training set and
            % testing set and Apply CFS each time for a new decision tree. 
            % The reason why we do that is addressed in the report.
            [select_sample, binary_target] = pre_process_cfs(train_input, train_target, j);
            trees{j} = decision_tree_learning(select_sample, binary_target);
        end
        
        cross_validation_matrix(:, :, i) = test_all_tree(valid_input, valid_target, trees);
    end  

    tree_confusion_matrix = sum(cross_validation_matrix, 3);
    tree_eval_matrix = cmatrix_to_evalmatrix(tree_confusion_matrix);
    
end