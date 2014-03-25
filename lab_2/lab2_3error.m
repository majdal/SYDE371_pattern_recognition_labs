close all;
clear all;

load('lab2_3.mat');

% draw the meshgrid
xDim = 50:1:550;
yDim = 0:1:450;
[x, y] = meshgrid(xDim,yDim);

%load data points into class
clA = featureclass(a);
clB = featureclass(b);

log = [];

tempnaB = 1;
tempnbA = 1;
j = 1;
% figure
% hold on;
remaining_A = size(clA.Cluster);
remaining_B = size(clB.Cluster);
count = 1;

error_rate = [];
class_error_rate = [];
%-----to be repeated until naB = nbA = 0, then reiterate to find new suitable
%disc
for i=1:20
while (remaining_A(:,1)>= 0) && (remaining_B(:,1) >= 0) && count < 7
    while ((tempnaB ~= 0) && (tempnbA ~= 0))
        %randomly pick prototype
        clA.prototype = clA.Cluster(randi(length(clA.Cluster(:,1)),1),:);
        clB.prototype = clB.Cluster(randi(length(clB.Cluster(:,1)),1),:); 

        MED_discA = l2functions.MEDdiscriminant(clA.prototype, clB.prototype, clA);
        MED_discB = l2functions.MEDdiscriminant(clA.prototype, clB.prototype, clB);

        confMat= l2functions.confusionMat(MED_discA, MED_discB);
        naB = confMat(1,2);
        nbA = confMat(2,1);
        disp(naB)
        disp(nbA)
        tempnaB = naB;
        tempnbA = nbA;
    end

    % fill the meshgrid with the boundary info
    %MED_boundary = l2functions.MEDBoundary(x, y, clA, clB);
    
    % if naB=0, then remove those points from b that G classifies as B
    if naB == 0
        indicies = [];
        for i = 1:length(MED_discB)
            if MED_discB(i) < 0
                indicies(end+1)=i;
            end
        end 
        size(indicies)
        clB.Cluster(indicies,:) = [];
    end 
    
    % if nbA=0, then remove those points from a that G classifies as A
    if nbA == 0
        indicies=[];
        for i = 1:length(MED_discA)
            if MED_discA(i) >= 0
                indicies(end+1)=i;
            end
        end
        size(indicies)
        clB.Cluster(indicies,:) = [];
    end 
    
    remaining_A = length(clA.Cluster);
    remaining_B = length(clB.Cluster);
    lol = 'new loop!'
    tempnaB = 1;
    tempnbA = 1;

    count = count + 1;
    %contour(xDim, yDim, MED_boundary, 1, 'k')
end
error_rate = [error_rate; (sum(confMat(:)) - trace(confMat)) / sum(confMat(:))];
clA = featureclass(a);
clB = featureclass(b);
remaining_A = length(clA.Cluster);
remaining_B = length(clB.Cluster);
count=1;

end


avg_error = mean(error_rate)
max_error = max(error_rate)
min_error = min(error_rate)
std_deviation = std(error_rate)

% hold on;
% l2functions.plotdata(a, 'g'); 
% hold on; 
% l2functions.plotdata(b, 'b');




