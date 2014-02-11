% SYDE Lab 0 - Matlab Introduction
% Feb 2nd 2013
clear all
close all

%n_points = 200;
xDim1 = -5:1:20;
yDim1 = 20:-1:5;

xDim2 = -10:1:25;
yDim2 = 30:-1:-10;
%grid = Functions.ConstructGrid(xDim,yDim)
[X1, Y1] = meshgrid(xDim1,yDim1);
[X2, Y2] = meshgrid(xDim2,yDim2);

%Case 1 Training Data
NA = 200;
NB = 200;
class_A = featureclass([5 10]',[8 0; 0 4],NA/(NA+NB));
class_B = featureclass([10 15]',[8 0;0 4],NA/(NA+NB));

rA = Functions.GenerateDist(class_A,NA);
rB = Functions.GenerateDist(class_B,NB);

MED_BoundaryCase1 = Functions.MEDBoundary2(X1,Y1,class_A,class_B);
GED_BoundaryCase1 = Functions.GEDBoundary2(X1,Y1,class_A,class_B);
MAP_BoundaryCase1 = Functions.MAPBoundary2(X1,Y1,class_A,class_B);

%K=1 therefore just NN
NN_BoundaryCase1 = Functions.KNNBoundary2(X1,Y1,rA,rB,1);
k5NN_BoundaryCase1 = Functions.KNNBoundary2(X1,Y1,rA,rB,5);

%Case 2 Training Data
NC = 100;
ND = 200;
NE = 150;
class_C = featureclass([5 10]',[8 4;4 40],NC/(NC+ND+NE));
class_D = featureclass([15 10]',[8 0;0 8],ND/(NC+ND+NE));
class_E = featureclass([10 5]',[10 -5;-5 20],NE/(NC+ND+NE));

rC = Functions.GenerateDist(class_C,NC);
rD = Functions.GenerateDist(class_D,ND);
rE = Functions.GenerateDist(class_E,NE);

MED_BoundaryCase2 = Functions.MEDBoundary3(X2,Y2,class_C,class_D,class_E);
GED_BoundaryCase2 = Functions.GEDBoundary3(X2,Y2,class_C,class_D,class_E);
MAP_BoundaryCase2 = Functions.MAPBoundary3(X2,Y2,class_C,class_D,class_E);

NN_BoundaryCase2 = Functions.KNNBoundary3(X2,Y2,rC,rD,rE,1);
k5NN_BoundaryCase2 = Functions.KNNBoundary3(X2,Y2,rC,rD,rE,5);

%Case 1 Testing Data
tA = Functions.GenerateDist(class_A,NA);
tB = Functions.GenerateDist(class_B,NB);

%Case 2 Testing Data
tC = Functions.GenerateDist(class_C,NC);
tD = Functions.GenerateDist(class_D,ND);
tE = Functions.GenerateDist(class_E,NE);

 figure
 subplot(1,2,1)
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
 title('MED,GED and MAP Plots for Case 1');
 [C6,h6]=contour(xDim1,yDim1,MED_BoundaryCase1,1);
 set(h6,'EdgeColor','c');
 [C7,h7]=contour(xDim1,yDim1,GED_BoundaryCase1,1);
 set(h7,'EdgeColor','m');
 [C10,h10]=contour(xDim1,yDim1,MAP_BoundaryCase1,1);
 set(h10,'EdgeColor','c');
 subplot(1,2,2)
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
 title('NN and KNN Plots for Case 1');
 [C8,h8]=contour(xDim1,yDim1,NN_BoundaryCase1,1);
 set(h8,'EdgeColor','c');
 hold on;
 [C9,h9]=contour(xDim1,yDim1,k5NN_BoundaryCase1,10);
 set(h9,'EdgeColor','m');
 
 figure
 subplot(1,2,1)
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
 title('MED, GED, MAP Plots for Case 2')
 [C3,h3]=contour(xDim2,yDim2,MED_BoundaryCase2,2);
 set(h3,'EdgeColor','c');
 [C4,h4]=contour(xDim2,yDim2,GED_BoundaryCase2,2);
 set(h4,'EdgeColor','m');
 [C5,h5]=contour(xDim2,yDim2,MAP_BoundaryCase2,2);
 set(h5,'EdgeColor','k');
 subplot(1,2,2)
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
 title('NN and KNN Plots for Case 2')
 [C1,h1] = contour(xDim2,yDim2,NN_BoundaryCase2,2);
 set(h1,'EdgeColor','c');
 hold on;
 [C2,h2] = contour(xDim2,yDim2,k5NN_BoundaryCase2,2);
 set(h2,'EdgeColor','m');
 
 med_error = Functions.error('Functions.MEDBoundary2', rA, rB, class_A, class_B);
 map_error = Functions.error('Functions.MAPBoundary2', rA, rB, class_A, class_B);
 ged_error = Functions.error('Functions.GEDBoundary2', rA, rB, class_A, class_B);
 nn_error = Functions.error('Functions.KNNBoundary2', tA, tB, rA, rB);
 knn_error = Functions.error_knn('Functions.KNNBoundary2', tA, tB, rA, rB, 5);
 
 med_error3 = Functions.error('Functions.MEDBoundary2', rC, rD, rE, class_C, class_D, class_E);
 map_error3 = Functions.error('Functions.MAPBoundary2', rC, rD, rE, class_C, class_D, class_E);
 ged_error3 = Functions.error('Functions.GEDBoundary2', rC, rD, rE, class_C, class_D, class_E);
 nn_error3 = Functions.error('Functions.KNNBoundary2', tC, tD, rE, rC, rD, rE);
 knn_error3 = Functions.error_knn('Functions.KNNBoundary2', tC, tD, rE, rC, rD, rE, 5);
 