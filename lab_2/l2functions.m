classdef l2functions
    methods (Static)
        
        function MED_Discriminant = MEDdiscriminant(proto1, proto2, class)
            x1 = class.Cluster;
            MED_Discriminant = (proto1 - proto2)*x1' + 0.5* ...
                (proto2*proto2' - proto1*proto1');
        end
        
        function error = error(MED_disc)
            error = size(MED_disc);
            [x y] = size(MED_disc);
            for j = 1:y
                for i = 1:x
                    if MED_disc(i,j) >= 0
                        error(i,j) = 1;
                    elseif MED_disc(i,j) < 0
                        error(i,j) = 0;
                    end
                end
            end
        end
        
        function plotstuff = plotdata(data)
            plotstuff = scatter(data(:,1), data(:,2),'Fill');
        end
        
        % MED classifier stuff 
        function MEDDist = MEDDist(X,Y,class)
            MEDDist = sqrt((X - class.prototype(1)).^2+(Y - class.prototype(2)).^2);
        end
        
        function  SV = GetSmallestValue(x,y)
            if x <= y
                SV = 0;
            else
                SV = 1;
            end    
        end
        
        function MED_Boundary = MEDBoundary(X, Y, class_1, class_2)
            MED_Boundary = zeros(size(X));
            MEDDist1 = l2functions.MEDDist(X,Y,class_1);
            MEDDist2 = l2functions.MEDDist(X,Y,class_2);

            [h,w] = size(MEDDist1);
            for i = 1:w
                for j = 1:h
                    MED_Boundary(j,i) = l2functions.GetSmallestValue(MEDDist1(j,i),MEDDist2(j,i));
                end
            end
        end 
        function confuscioussays = confusionMat(disc1, disc2)
            true_positives_1 = sum(disc1(:) >= 0);
            true_positives_2 = sum(disc2(:) < 0);
            false_rejections_2 = 200-true_positives_1;
            false_rejections_1 = 200-true_positives_2;
            confuscioussays = [true_positives_1    false_rejections_2;
                         false_rejections_1  true_positives_2
            ];
        end

    end
end