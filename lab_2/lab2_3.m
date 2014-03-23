close all;
clear all;

load('lab2_3.mat');

clA = featureclass(a, 'r');
clB = featureclass(b, 'b');

clA.mu = l2functions.calcMean(clA);
clB.mu = l2functions.calcMean(clB);

protA = clA.Cluster(randi(length(clA.Cluster(:,1)),1),:);
protB = clB.Cluster(randi(length(clB.Cluster(:,1)),1),:); 

MED_discA = l2functions.MEDdiscriminant(protA, protB, clA, clB);

error = l2functions.error(MED_discA);

figure
l2functions.plotdata(clA); hold on; l2functions.plotdata(clB);





