classdef Functions
    
    methods (Static = true)
        function GD = GenerateDist(class, n_points)
            GD = mvnrnd(class.mu, class.sigma, n_points);
        end
        
        function MG = ConstructGrid(x_range,y_range)
           MG = meshgrid(x_range,y_range); 
        end
        
        function MED_Distance = MEDDistance(data_point,class)
            MED_Distance = sqrt((data_point - class.mu)'*(point - class.mu));
        end
        
       function MEDDist = MEDDist(X,Y,class)
        
            MEDDist = sqrt((X - class.mu(1)).^2+(Y - class.mu(2)).^2);
        end
        
        function MED_Boundary = MEDBoundary(X,Y,class_1,class_2)
        MED_Boundary = zeros(length(X),length(Y));
        MEDDist1 = Functions.MEDDist(X,Y,class_1);
        MEDDist2 = Functions.MEDDist(X,Y,class_2);
        
        [h,w] = size(MEDDist1);
        for i = 1:w
            for j = 1:h
                
                MED_Boundary(j,i) = Functions.GetSmallestValue(MEDDist1(j,i),MEDDist2(j,i))
            end
        end
        end
        
        function  SV = GetSmallestValue(x,y)
        
            if x >= y
                SV = 1;
            else
                SV = 0;
            end
        
        end
        
        
    
    end
end