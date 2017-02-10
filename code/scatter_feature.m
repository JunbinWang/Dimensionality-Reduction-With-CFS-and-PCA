% This function is used to draw scatters of two most important features of
% each emotion. The input values are examle values(x from the emotinaol datadet) of all the dataset and taeget values(y of the emotional dataset) of all the dataset. 
function scatter_feature(example, target)
    emotion = 6;
    scatter_x = zeros(6, 1);
    scatter_y = zeros(6, 1);
    
    % Store the two most important features of each emotion in 2 variables
    for i = 1 : emotion
        [~, ~, features] = pre_process_cfs(example, target, i);
        disp(features);
        scatter_x(i) = features(1);
        scatter_y(i) = features(2);
    end
   
    % Plot all the 6 subgraphs in a main graph in 2x3 format.
    % Give dataset which the output value is the same as target value different shape from other dataset. 
   figure
   for i = 1 : emotion
       subplot(2,3,i);
       f = gscatter(example(:, scatter_x(i)), example(:, scatter_y(i)), (target==i), 'br','vs', 3);
       grid on
       xlabel(sprintf('Feature - %d', scatter_x(i)));
       ylabel(sprintf('Feature - %d', scatter_y(i)));
       title(sprintf('Emotion %d', i));
       set(f(1), 'MarkerFaceColor', 'g')
       set(f(2), 'MarkerFaceColor', 'y')
   end
   
   set(gcf,'units','centimeters')
   set(gcf,'papersize',[10,5.6])
   set(gcf,'paperposition',[0,0,10,5.6])
   print -depsc epsFig
end