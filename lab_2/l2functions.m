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
            xDim = ;
    end
end