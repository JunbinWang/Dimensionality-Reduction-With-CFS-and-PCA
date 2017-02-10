% This function wil go through the tree according to the threshold of node
% and stop until it reach the leaf node and return the node class as
% result.
function result = classify_by_tree(features, tree)

        if ~isempty(tree.class)
            result = tree.class(1,1);
            return
        end
        
        feature_id = tree.op(1,1);
        threshold = tree.op(1,2);
        
        left = tree.kids{1};
        right = tree.kids{2};
              
        value = features(feature_id);
        
        if (threshold >= value)
           result = classify_by_tree(features, left);
        else
           result = classify_by_tree(features, right);
        end       
end

