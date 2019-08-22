function PredictedClass = NearestNeighbor(Data)
Hold = [];
for i = 1:size(Data, 1)
    ClosestDistance = 999;
    index = 0;
    for j = 1:size(Data, 1)
        if(j ~= i)
            FoundDistance = norm(Data(i,2:size(Data,2))-Data(j,2:size(Data,2)));
            if(FoundDistance < ClosestDistance)
                ClosestDistance = FoundDistance;
                index = j;
                
            end
        end
    end
    Hold = [Hold, Data(index)];
end
PredictedClass = Hold;
end

