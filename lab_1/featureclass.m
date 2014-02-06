classdef featureclass
    
    properties
        mu
        sigma
    end
    
    methods
        function FC = featureclass(mu,sigma)
            FC.mu = mu;
            FC.sigma = sigma;
        end
    end
end

    
    