close all;
clear all;

load('lab2_3.mat');

% draw the meshgrid
xDim = 50:1:550;
yDim = 0:1:450;
[x, y] = meshgrid(xDim,yDim);

%load data points into class
clA = featureclass(a, 'r');
clB = featureclass(b, 'b');

naB = 1;
nbA = 1;
j = 1;

remaining_A = size(clA.Cluster);
remaining_B = size(clB.Cluster);
%-----to be repeated until naB = nbA = 0, then reiterate to find new suitable
%disc
while (remaining_A(:,1)> 0) && (remaining_B(:,1) > 0)
    while ((naB > 0) && (nbA > 0))
        %randomly pick prototype
        protA = clA.Cluster(randi(length(clA.Cluster(:,1)),1),:);
        protB = clB.Cluster(randi(length(clB.Cluster(:,1)),1),:); 

        clA.prototype = protA;
        clB.prototype = protB;

        MED_discA = l2functions.MEDdiscriminant(clA.prototype, clB.prototype, clA);
        MED_discB = l2functions.MEDdiscriminant(clA.prototype, clB.prototype, clB);

        confMat= l2functions.confusionMat(MED_discA, MED_discB);
        naB = confMat(1,2);
        nbA = confMat(2,1);
        disp(naB)
        disp(nbA)
    end

    % fill the meshgrid with the boundary info
    MED_boundary = l2functions.MEDBoundary(x, y, clA, clB);
    
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
    naB = 1;
    nbA = 1;
end 

figure
l2functions.plotdata(clA); 
hold on; 
l2functions.plotdata(clB);
contour(xDim, yDim, MED_boundary, 1)




