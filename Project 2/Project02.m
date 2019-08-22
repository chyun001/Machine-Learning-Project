clc;clear;
SmallData = load('LargeData21.mat');
data = SmallData.CS170LARGEtestdata21;

current_set_of_features = []; % Initialize an empty set
UltimateAccuracy = 0;
UltimateFeatures = [];

%Testing Stuff (Delete Later)
test = 1:size(data,2)-1;
test(1) = [];
EmptySet = [22];
%testt = size(data,2);
%current_set_of_features_dummy = [6,97];
%accuracy = leave_one_out_cross_validation(data,current_set_of_features_dummy,EmptySet);
%

AlgorithmChoice = input('Type the number of the algorithm you want to run. ');

if(AlgorithmChoice == 1)
current_set_of_features_dummy = [];
disp('This dataset has 10 features (not including the class attribute), with 200 instances.')
disp('Running nearest neighbor with all 10 features, using "leaving-one-out" evaluation, I get an accuracy of ')
disp('Beginning search.')
for i = 1 : size(data,2)-1 
    disp('----------------------------------------------------------------')
    feature_to_add_at_this_level = [];
    best_so_far_accuracy    = 0;    
    
     for k = 1 : size(data,2)-1 
       if isempty(intersect(current_set_of_features,k)) % Only consider adding, if not already added.
        accuracy = leave_one_out_cross_validation(data,current_set_of_features_dummy,k+1);
        disp(['    Using feature(s) {', num2str(k),' ',num2str(current_set_of_features), '} accuracy is ',num2str(accuracy*100)])
        
        if accuracy > best_so_far_accuracy 
            best_so_far_accuracy = accuracy;
            feature_to_add_at_this_level = k;            
        end        
      end
     end
    current_set_of_features(i) =  feature_to_add_at_this_level;
    current_set_of_features_dummy(i) =  feature_to_add_at_this_level+1;
    if (best_so_far_accuracy > UltimateAccuracy || size(UltimateFeatures, 2) < 3)
        UltimateAccuracy = best_so_far_accuracy;
        UltimateFeatures = current_set_of_features;
    else
        disp([newline, '(Warning, Accuracy has decreased! Continuing search in case of local maxima)'])
    end
    disp(['Feature set {', num2str(current_set_of_features),'} was best, accuracy is ',num2str(best_so_far_accuracy*100)])
        
end
disp([newline, 'Finished search!! The best feature subset is {', num2str(UltimateFeatures), '} which has an accuracy of ', num2str(UltimateAccuracy*100)])
end

if(AlgorithmChoice == 2)
%Backward Elimination
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
current_set_of_features = 2:size(data,2); % Initialize
current_set_of_features_dummy = 2:size(data,2); % Initialize
EmptySet = [];

disp('This dataset has 10 features (not including the class attribute), with 200 instances.')
disp('Running nearest neighbor with all 10 features, using "leaving-one-out" evaluation, I get an accuracy of ')
disp('Beginning search.')
for i = 1 : size(current_set_of_features,2)
    disp('----------------------------------------------------------------')
    feature_to_drop_at_this_level = [];
    best_so_far_accuracy    = 0;    
    
     for k = 1 : size(current_set_of_features,2)
       %if (current_set_of_features(k) ~= k) 
       current_set_of_features_dummy = current_set_of_features;
       current_set_of_features_dummy(k) =  [];
        accuracy = leave_one_out_cross_validation(data,current_set_of_features_dummy,EmptySet);
        disp(['    Ditching feature(s) {', num2str(current_set_of_features(k)-1),'} accuracy is ',num2str(accuracy*100)])
        
        if accuracy > best_so_far_accuracy 
            best_so_far_accuracy = accuracy;
            feature_to_drop_at_this_level = k;            
        end        
      %end
     end
    current_set_of_features(feature_to_drop_at_this_level) = [];
    if best_so_far_accuracy > UltimateAccuracy
        UltimateAccuracy = best_so_far_accuracy;
        UltimateFeatures = current_set_of_features;
    else
        disp([newline, '(Warning, Accuracy has decreased! Continuing search in case of local maxima)'])
    end
    disp(['Feature set {', num2str(current_set_of_features-1),'} was best, accuracy is ',num2str(best_so_far_accuracy*100)])
        
end
disp([newline, 'Finished search!! The best feature subset is {', num2str(UltimateFeatures-1), '} which has an accuracy of ', num2str(UltimateAccuracy*100)])
end

