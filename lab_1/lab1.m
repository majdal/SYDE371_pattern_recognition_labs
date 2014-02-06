% SYDE Lab 0 - Matlab Introduction
% Feb 2nd 2013
clear all
close all

% muA = [5 10]';
% muB = [10 15]';
% muC = [5 10]';
% muD = [15 10]';
% muE = [10 5]';
% 
% sigmaA = [8 0; 0 4];
% sigmaB = [8 0;0 4];
% sigmaC = [8 4;4 40];
% sigmaD = [8 0;0 8];
% sigmaE = [10 -5;-5 20];

class_A = featureclass([5 10]',[8 0; 0 4]);
class_B = featureclass([10 15]',[8 0;0 4]);

NA = 200;
NB = 200;
NC = 100;
ND = 200;
NE = 150;

n_points = 200;
xDim = -5:4:20;
yDim = 20:-4:-5;

%grid = Functions.ConstructGrid(xDim,yDim)
[X, Y] = meshgrid(xDim,yDim);

%Case 1

rA = Functions.GenerateDist(class_A,NA);
rB = Functions.GenerateDist(class_B,NB);

MED_Boundary = Functions.MEDBoundary(X,Y,class_A,class_B)
%M = Functions.MEDDist(X,Y,class_A)

 plot(rA(:,1),rA(:,2),'.');
 hold on;
 plot(rB(:,1),rB(:,2),'o');
 hold on;
 plot_ellipse(class_A);
 hold on;
 plot_ellipse(class_B);
 hold on;
 contour(xDim,yDim,MED_Boundary,[1]);

 

