classdef featureclass
    properties
        mu
        var
        cov
        Colour
        Cluster
    end
    methods
        function obj = featureclass(data_point, colour)
            mu = (1/(length(data_point)))*sum(data_point);
            var = [];
            cov = [];
            obj.Colour = colour;
            obj.Cluster = data_point;
        end
    end
end