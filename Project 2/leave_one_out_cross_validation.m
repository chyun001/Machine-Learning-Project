function accuracy = leave_one_out_cross_validation(data, current_set, feature_to_add)

%Adds the new feature to the current list of features
Features = [current_set, feature_to_add]; 
PassToNN(:,1) = data(:,1);

%Creates a subset of the data with only features in variable Features
for i = 1:size(Features, 2)
    PassToNN = [PassToNN, data(:,Features(1,i))];
end

%Calls the NearestNeighbor function and returns the predicted class label
PredictedLabels = NearestNeighbor(PassToNN);

%The for loop below compares the predicted lable with the correct label
CorrectLabels = 0;
for i = 1:size(PredictedLabels, 2)
    if(PredictedLabels(1,i) == data(i))
        CorrectLabels = CorrectLabels + 1;
    end
end

%Returns how accurate the predicted labels were
accuracy = CorrectLabels/size(data, 1);
end

