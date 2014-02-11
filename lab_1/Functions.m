classdef Functions
    
    methods (Static = true)
        function GD = GenerateDist(class, n_points)
            GD = mvnrnd(class.mu, class.sigma, n_points);
        end
        
        function MED_Distance = MEDDistance(data_point,class)
            MED_Distance = sqrt((data_point - class.mu)'*(point - class.mu));
        end
        
       function MEDDist = MEDDist(X,Y,class)
        
            MEDDist = sqrt((X - class.mu(1)).^2+(Y - class.mu(2)).^2);
       end
       
       function GEDDist = GEDDist(x,y,class)
           temp = [x y]' - class.mu;
           GEDDist = temp'*inv(class.sigma)*temp;
       end
       
       function MAPDist = MAPDist(x,y,class)
          MAPDist = class.prob*exp(-0.5*Functions.GEDDist(x,y,class))/(det(class.sigma))^(0.5);
       end
        
        function MED_Boundary = MEDBoundary2(X,Y,class_1,class_2)
            MED_Boundary = zeros(size(X));
            MEDDist1 = Functions.MEDDist(X,Y,class_1);
            MEDDist2 = Functions.MEDDist(X,Y,class_2);

            [h,w] = size(MEDDist1);
            for i = 1:w
                for j = 1:h

                    MED_Boundary(j,i) = Functions.GetSmallestValue2(MEDDist1(j,i),MEDDist2(j,i));
                end
            end
        end
        
        function MED_Boundary = MEDBoundary3(X,Y,class_1,class_2,class_3)
            MED_Boundary = zeros(size(X));
            MEDDist1 = Functions.MEDDist(X,Y,class_1);
            MEDDist2 = Functions.MEDDist(X,Y,class_2);
            MEDDist3 = Functions.MEDDist(X,Y,class_3);

            [h,w] = size(MEDDist1);
            for i = 1:w
                for j = 1:h

                    MED_Boundary(j,i) = Functions.GetSmallestValue3(MEDDist1(j,i),MEDDist2(j,i),MEDDist3(j,i));
                end
            end
        end
        
        function  SV = GetSmallestValue3(x,y,z)
            if x <= y
                SV = 0;
            else
                SV = 1;
            end
            if z <= y && z <= x
                SV = 2;
            end
                
        end
        
        function  SV = GetSmallestValue3MAP(x,y,z)
            if x >= y
                SV = 0;
            else
                SV = 1;
            end
                if z >= y && z >= x
                    SV = 2;
                end
                
        end
        
        function  SV = GetSmallestValue2(x,y)
            if x <= y
                SV = 0;
            else
                SV = 1;
            end
                
        end
        
        function GED_Boundary = GEDBoundary2(X,Y,class_1,class_2)
            GED_Boundary = zeros(size(X));

            [h,w] = size(GED_Boundary);
            for i = 1:w
                for j = 1:h
                    GEDDist1 = Functions.GEDDist(X(1,i),Y(j,1), class_1);
                    GEDDist2 = Functions.GEDDist(X(1,i),Y(j,1), class_2);
                    GED_Boundary(j,i) = Functions.GetSmallestValue2(GEDDist1,GEDDist2);
                end
            end
            
        end
        
         function GED_Boundary = GEDBoundary3(X,Y,class_1,class_2,class_3)
            GED_Boundary = zeros(size(X));

            [h,w] = size(GED_Boundary);
            for i = 1:w
                for j = 1:h
                    GEDDist1 = Functions.GEDDist(X(1,i),Y(j,1), class_1);
                    GEDDist2 = Functions.GEDDist(X(1,i),Y(j,1), class_2);
                    GEDDist3 = Functions.GEDDist(X(1,i),Y(j,1), class_3);
                    GED_Boundary(j,i) = Functions.GetSmallestValue3(GEDDist1,GEDDist2,GEDDist3);
                end
            end
            
         end
         
         function MAP_Boundary = MAPBoundary2(X,Y,class_1,class_2)
            MAP_Boundary = zeros(size(X));

            [h,w] = size(MAP_Boundary);
            for i = 1:w
                for j = 1:h
                    MAPDist1 = Functions.MAPDist(X(1,i),Y(j,1), class_1);
                    MAPDist2 = Functions.MAPDist(X(1,i),Y(j,1), class_2);
                    MAP_Boundary(j,i) = Functions.GetSmallestValue2(MAPDist1,MAPDist2);
                end
            end
            
         end
        
         function MAP_Boundary = MAPBoundary3(X,Y,class_1,class_2,class_3)
            MAP_Boundary = zeros(size(X));

            [h,w] = size(MAP_Boundary);
            for i = 1:w
                for j = 1:h
                    MAPDist1 = Functions.MAPDist(X(1,i),Y(j,1), class_1);
                    MAPDist2 = Functions.MAPDist(X(1,i),Y(j,1), class_2);
                    MAPDist3 = Functions.MAPDist(X(1,i),Y(j,1), class_3);
                    MAP_Boundary(j,i) = Functions.GetSmallestValue3MAP(MAPDist1,MAPDist2,MAPDist3);
                end
            end
            
         end
         
         %sorting function from Mathworks
         function [smallestNElements smallestNIdx] = getNElements(A, n)
             [ASorted AIdx] = sort(A);
             smallestNElements = ASorted(1:n);
             smallestNIdx = AIdx(1:n);
            end
        
         function EucledianDistance = EucledeanDistance2(X,Y,r1)
             EucledianDistance = sqrt((X - r1(:,1)).^2+(Y - r1(:,2)).^2);
         end
         
         function KNN_Boundary = KNNBoundary2(X,Y,r1,r2,K)
             if ~exist('K', 'var') || isempty(K)
                K = 1;
            end
             KNN_Boundary = zeros(size(X));
             EucDist1 = 50;
             EucDist2 = 50;
             
             [h,w] = size(KNN_Boundary);
             
             for i = 1:w
                for j = 1:h

                        temp1 = Functions.EucledeanDistance2(X(1,i),Y(j,1),r1);
                        EucDist1 = Functions.getNElements(temp1,K);

                        temp2 = Functions.EucledeanDistance2(X(1,i),Y(j,1),r2);
                        EucDist2 = Functions.getNElements(temp2,K);

                    %if K == 1
                        class1_mean = mean(EucDist1);
                        class2_mean = mean(EucDist2);
                        KNN_Boundary(j,i) = Functions.GetSmallestValue2(class1_mean,class2_mean);
                        EucDist1 = 50;
                        EucDist2 = 50;
                    %end
                    
                    
                end
             end
         end
         
         function KNN_Boundary = KNNBoundary3(X,Y,r1,r2,r3,K)
             if ~exist('K', 'var') || isempty(K)
                K = 1;
            end
             KNN_Boundary = zeros(size(X));
             EucDist1 = 50;
             EucDist2 = 50;
             EucDist3 = 50;
             
             [h,w] = size(KNN_Boundary);
             
             for i = 1:w
                for j = 1:h

                        temp1 = Functions.EucledeanDistance2(X(1,i),Y(j,1),r1);
                        EucDist1 = Functions.getNElements(temp1,K);

                        temp2 = Functions.EucledeanDistance2(X(1,i),Y(j,1),r2);
                        EucDist2 = Functions.getNElements(temp2,K);
                        
                        temp3 = Functions.EucledeanDistance2(X(1,i),Y(j,1),r3);
                        EucDist3 = Functions.getNElements(temp3,K);

                        class1_mean = mean(EucDist1);
                        class2_mean = mean(EucDist2);
                        class3_mean = mean(EucDist3);
                        KNN_Boundary(j,i) = Functions.GetSmallestValue3(class1_mean,class2_mean,class3_mean);
                        EucDist1 = 50;
                        EucDist2 = 50;
                        EucDist3 = 50;                    
                    
                end
            end
        end
        
        function error = error(classifier, distribution_1, distribution_2, class_A, class_B)
            [x_1, y_1] = size(distribution_1);
            [x_2, y_2] = size(distribution_2);

            fn = str2func(classifier);
            error_1 = fn(distribution_1(:,1), distribution_1(:,2), class_A, class_B);
            error_2 = fn(distribution_2(:,1), distribution_2(:,2), class_A, class_B);
            
            true_positives_1 = sum(error_1(:)==0);
            false_rejections_1 = x_1-true_positives_1;

            true_positives_2 = sum(error_2(:)==1);
            false_rejections_2 = x_2-true_positives_2;
            
            confusion = [true_positives_1    false_rejections_2;
                         false_rejections_1  true_positives_2
            ];
            %disp(false_rejections_1/x_1);
            %disp(false_rejections_2/x_2);
            
            error = confusion;
        end
        function error = error_knn(classifier, distribution_1, distribution_2, class_A, class_B, k)
            [x_1, y_1] = size(distribution_1);
            [x_2, y_2] = size(distribution_2);

            fn = str2func(classifier);
            error_1 = fn(distribution_1(:,1), distribution_1(:,2), class_A, class_B, k);
            error_2 = fn(distribution_2(:,1), distribution_2(:,2), class_A, class_B, k);
            
            true_positives_1 = sum(error_1(:)==0);
            false_rejections_1 = x_1-true_positives_1;

            true_positives_2 = sum(error_2(:)==1);
            false_rejections_2 = x_2-true_positives_2;
            
            confusion = [true_positives_1    false_rejections_2;
                         false_rejections_1  true_positives_2
            ];
            %disp(false_rejections_1/x_1);
            %disp(false_rejections_2/x_2);
            
            error = confusion;
        end
        
            function error = error3(classifier, distribution_1, ...
                    distribution_2, distribution_3, class_A, class_B, class_C)
            [x_1, y_1] = size(distribution_1);
            [x_2, y_2] = size(distribution_2);
            [x_3, y_3] = size(distribution_3);

            fn = str2func(classifier);
            error_1 = fn(distribution_1(:,1), distribution_1(:,2), class_A, class_B, class_C);
            error_2 = fn(distribution_2(:,1), distribution_2(:,2), class_A, class_B, class_C);
            error_3 = fn(distribution_3(:,1), distribution_3(:,2), class_A, class_B, class_C);
            
            true_positives_1 = sum(error_1(:)==0);
            false_rejections_1 = x_1-true_positives_1;

            true_positives_2 = sum(error_2(:)==1);
            false_rejections_2 = x_2-true_positives_2;
            
            true_positives_3 = sum(error_3(:)==2);
            false_rejections_3 = x_3-true_positives_3;
            
            confusion = [true_positives_1    true_positives_2     true_positives_3;
                         false_rejections_1  false_rejections_2   false_rejections_3;
            ];
            disp(false_rejections_1/x_1);
            disp(false_rejections_2/x_2);
            disp(false_rejections_3/x_3);
            
            error = confusion;
            end
        function error = error_knn3(classifier, distribution_1, ...
                    distribution_2, distribution_3, class_A, class_B, class_C, k)
            [x_1, y_1] = size(distribution_1);
            [x_2, y_2] = size(distribution_2);
            [x_3, y_3] = size(distribution_3);

            fn = str2func(classifier);
            error_1 = fn(distribution_1(:,1), distribution_1(:,2), class_A, class_B, class_C, k);
            error_2 = fn(distribution_2(:,1), distribution_2(:,2), class_A, class_B, class_C, k);
            error_3 = fn(distribution_3(:,1), distribution_3(:,2), class_A, class_B, class_C, k);
            
            true_positives_1 = sum(error_1(:)==0);
            false_rejections_1 = x_1-true_positives_1;

            true_positives_2 = sum(error_2(:)==1);
            false_rejections_2 = x_2-true_positives_2;
            
            true_positives_3 = sum(error_3(:)==2);
            false_rejections_3 = x_3-true_positives_3;
            
            confusion = [true_positives_1    true_positives_2     true_positives_3;
                         false_rejections_1  false_rejections_2   false_rejections_3;
            ];
            disp(false_rejections_1/x_1);
            disp(false_rejections_2/x_2);
            disp(false_rejections_3/x_3);
            
            error = confusion;
        end
    end
end