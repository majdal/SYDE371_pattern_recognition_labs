classdef featureclass
    
    properties
        mu
        sigma
        prob
    end
    
    methods
        function FC = featureclass(mu,sigma,prob)
            FC.mu = mu;
            FC.sigma = sigma;
            FC.prob = prob;
        end
    end
end

    
    