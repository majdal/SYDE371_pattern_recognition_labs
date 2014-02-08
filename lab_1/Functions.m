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
        
        
        
    
    end
end