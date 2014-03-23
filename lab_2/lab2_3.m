close all;
clear all;

load('lab2_3.mat');

%load data points into class
clA = featureclass(a, 'r');
clB = featureclass(b, 'b');

%calculate mean of data set points for MED
clA.mu = l2functions.calcMean(clA);
clB.mu = l2functions.calcMean(clB);

naB = 1;
nbA = 1;
j = 1;

%-----to be repeated until naB = nbA = 0, then reiterate to find new suitable
%disc
while ((naB > 0) && (nbA > 0))
%randomly pick prototype
protA = clA.Cluster(randi(length(clA.Cluster(:,1)),1),:);
protB = clB.Cluster(randi(length(clB.Cluster(:,1)),1),:); 

% draw the meshgrid
xDim = 50:1:550;
yDim = 0:1:450;
[x, y] = meshgrid(xDim,yDim);

% fill the meshgrid with the boundary info
MED_boundary = l2functions.MEDBoundary2(x, y, clA, clB);

MED_discA = l2functions.MEDdiscriminant(protA, protB, clA, clB);

error = l2functions.error(MED_discA);

confMat= l2functions.confusionMat(error);
naB = confMat(1,2);
nbA = confMat(2,1);
end


figure
l2functions.plotdata(clA); hold on; l2functions.plotdata(clB);
hold
contour(xDim, yDim, MED_boundary, 1)




