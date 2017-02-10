% This function is the key function to produce a binary decision tree
% according to the sample data and their labels. It will product a decision
% tree which can classify the target label as users input.
function tree = decision_tree_learning(examples, labels)

    [~, total_feature_count] = size(examples);
    
    %Set the binary label value to 1 if it is the same as target label,otherwise set it to 0

    % If all samples has the same label, return a leaf node with class 0 or 1 depends on samples. 
    if(length(unique(labels))==1)
        tree.op=[];
        tree.kids={};
        tree.class=unique(labels);
        return;
    end
    
    % If all attributes has been used, return a leaf node with the most
    % common label as the calss.
    if(length(find(isnan(examples(1,:))))==total_feature_count)
        tree.op = [];
        tree.kids = {};
        tree.class = mode(labels);
        return;
    end
    
    [best_feature, best_threshold] = choose_attribute(examples, labels);
    [left_subset, left_labels, right_subset, right_labels] = divide_by_feature(best_feature, best_threshold, examples, labels);

    % If the left subset is empty, then return a empty leaf node.
    if (isnan(left_subset))
        left_tree.op = [];
        left_tree.kids = {};
        left_tree.class = mode(labels);
    else
        left_tree = decision_tree_learning(left_subset,left_labels);
    end
    
    % If the right subset is empty, then return a empty right node.
    if (isnan(right_subset))
        right_tree.op = [];
        right_tree.kids = {};
        right_tree.class = mode(labels);
    else
        right_tree = decision_tree_learning(right_subset,right_labels);
    end
    
    tree.op = [best_feature, best_threshold];
    tree.kids = {left_tree, right_tree};
    tree.class = [];
end

    
