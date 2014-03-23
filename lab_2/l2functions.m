classdef l2functions
    methods (Static)
        function mean = calcMean(class)
            mean = ((1/length(class.Cluster))*sum(class.Cluster));
        end
        
        function MED_Discriminant = MEDdiscriminant(proto1, proto2, class1, class2)
            x1 = class1.Cluster;
            x2 = class2.Cluster;
            MED_Discriminant(1,:) = (proto1 - proto2)*x1' + 0.5* ...
                (proto2*proto2' - proto1*proto1');
            MED_Discriminant(2,:) = (proto1 - proto2)*x2' + 0.5* ...
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
        
        function confuscioussays = confusionMat(error)
            true_positives_1 = sum(error(1,:)==1);
            true_positives_2 = sum(error(2,:)==0);
            false_rejections_2 = 200-true_positives_1;
            false_rejections_1 = 200-true_positives_2;
            confuscioussays = [true_positives_1    false_rejections_2;
                         false_rejections_1  true_positives_2
            ];
        end
    end
end