% This function take a confusion function as input and output a 7x3 eval_matrix.
% The first 6 row  of this matix contains the recall, prescion and F1 value
% for each lable. The last row of this matrix contains the average values
% of recall, prescion and F1 value of these 6 labels.
function eval_matrix = cmatrix_to_evalmatrix(c_matrix)

    [r,~] = size(c_matrix);
    eval_matrix = zeros(r + 1, 3);

     for i = 1 : r   
            recall = c_matrix(i,i) / sum(c_matrix(i, :));
            precise = c_matrix(i,i) / sum(c_matrix(: , i));
            F1 = (2 * recall * precise) / (recall + precise);

            if(isnan(F1))
                F1 = 0;
            end

            eval_matrix(i, :) = [recall, precise, F1];
     end

     % Finally calculate the average perfomance.
     eval_matrix(r + 1, :) = sum(eval_matrix, 1) / r;

end