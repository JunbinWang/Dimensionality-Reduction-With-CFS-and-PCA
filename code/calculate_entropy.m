%This function is used to calculate the entropy of a dataset, 
function entropy = calculate_entropy(binary_labels)

      label_count = length(binary_labels);
      
      positive_count = length(find(binary_labels==1));
      negative_count = label_count - positive_count;
      
      if (positive_count == 0 || negative_count ==0)
          entropy = 0;
      else
          p_p = positive_count/label_count;
          p_n = negative_count/label_count;
          entropy = -(p_p)*log2(p_p) - (p_n)*log2(p_n);  
      end
end
      