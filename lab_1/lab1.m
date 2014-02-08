% SYDE Lab 0 - Matlab Introduction
% Feb 2nd 2013
clear all
close all

NA = 200;
NB = 200;
NC = 100;
ND = 200;
NE = 150;

class_A = featureclass([5 10]',[8 0; 0 4],NA/(NA+NB));
class_B = featureclass([10 15]',[8 0;0 4],NA/(NA+NB));
class_C = featureclass([5 10]',[8 4;4 40],NC/(NC+ND+NE));
class_D = featureclass([15 10]',[8 0;0 8],NC/(NC+ND+NE));
class_E = featureclass([10 5]',[10 -5;-5 20],NC/(NC+ND+NE));



%n_points = 200;
xDim1 = -5:0.5:20;
yDim1 = 20:-0.5:5;

xDim2 = -10:1:25;
yDim2 = 30:-1:-10;
[X2, Y2] = meshgrid(xDim2,yDim2);

%grid = Functions.ConstructGrid(xDim,yDim)
[X1, Y1] = meshgrid(xDim1,yDim1);

%Case 1

rA = Functions.GenerateDist(class_A,NA);
rB = Functions.GenerateDist(class_B,NB);
rC = Functions.GenerateDist(class_C,NC);
rD = Functions.GenerateDist(class_D,ND);
rE = Functions.GenerateDist(class_E,NE);

MED_BoundaryCase1 = Functions.MEDBoundary2(X1,Y1,class_A,class_B);
GED_BoundaryCase1 = Functions.GEDBoundary2(X1,Y1,class_A,class_B);
MAP_BoundaryCase1 = Functions.MAPBoundary2(X1,Y1,class_A,class_B);

MED_BoundaryCase2 = Functions.MEDBoundary3(X2,Y2,class_C,class_D,class_E);
GED_BoundaryCase2 = Functions.GEDBoundary3(X2,Y2,class_C,class_D,class_E);
MAP_BoundaryCase2 = Functions.MAPBoundary3(X2,Y2,class_C,class_D,class_E);

 figure
 plot(rA(:,1),rA(:,2),'b.');
 hold on;
 plot(rB(:,1),rB(:,2),'ro');
 hold on;
 plot_ellipse(class_A,'b');
 hold on;
 plot_ellipse(class_B,'g');
 hold on;
 xlabel('feature1');
 ylabel('feature2');
 contour(xDim1,yDim1,MED_BoundaryCase1,1);
 contour(xDim1,yDim1,GED_BoundaryCase1,1);
 contour(xDim1,yDim1,MAP_BoundaryCase1,1);
 
 
 figure
 plot(rC(:,1),rC(:,2),'b.');
 hold on;
 plot(rD(:,1),rD(:,2),'go');
 hold on;
 plot(rE(:,1),rE(:,2),'rx');
 hold on;
 plot_ellipse(class_C,'b');
 hold on;
  plot_ellipse(class_D,'g');
 hold on;
  plot_ellipse(class_E,'r');
 hold on;
 xlabel('feature1');
 ylabel('feature2');
 contour(xDim2,yDim2,MED_BoundaryCase2,2);
 contour(xDim2,yDim2,GED_BoundaryCase2,2);
 contour(xDim2,yDim2,MAP_BoundaryCase2,2);
 
 

 

