classdef l2functions
    methods (Static)
        function mean = calcMean(class)
            mean = ((1/length(class.Cluster))*sum(class.Cluster));
        end
        
        function MED_Discriminant = MEDdiscriminant(proto1, proto2, class1, class2)
            MED_Discriminant(1,:) = (proto1 - proto2)*class1.Cluster' + 0.5* ...
                (proto2*proto2' - proto1*proto1');
            MED_Discriminant(2,:) = (proto1 - proto2)*class2.Cluster' + 0.5* ...
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
        
        function plotstuff = plotdata(class)
            plotstuff = scatter(class.Cluster(:,1), class.Cluster(:,2),'Fill');
        end
        
        function discCont = disc_contour(MED_Disc, class1, class2)
            % xDim = ;
        end 
        
        % MED classifier stuff 
        function MEDDist = MEDDist(X,Y,class)
            MEDDist = sqrt((X - class.mu(1)).^2+(Y - class.mu(2)).^2);
        end
        
        function  SV = GetSmallestValue(x,y)
            if x <= y
                SV = 0;
            else
                SV = 1;
            end    
        end
        
        function MED_Boundary = MEDBoundary2(X, Y, class_1, class_2)
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
    end
end