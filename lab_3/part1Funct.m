classdef part1Funct



    methods (Static = true)

        function value = MICDClassifier(mu, sigma, x, classes)

            dist = zeros(classes, 1);
            for n = 1:classes
                dist(n) = sqrt((x - mu(:, n))'*(inv(sigma(:, :, n)))*(x - mu(:, n)));
            end
            [t, MICD] = min(dist);
            value = MICD;
        end


        function [mu, sigma] = GetImageParameters(featureset,classes,samples)

                
                mu = zeros(2,classes);
                sigma = zeros(2,2,classes);

%                 if (featureset==2)
%                     item = f2;
%                 elseif (featureset==8)
%                     item = f8;
%                 elseif (featureset==32)
%                     item = f32;
%                 end

               for nImage=1:classes
                   index = nImage*samples-samples;


                   x = featureset(1,(index+1):(index+samples));
                   y = featureset(2,(index+1):(index+samples));

                   mu(:,nImage) = [mean(x) mean(y)];
                   sigma(:,:,nImage) = cov(x,y);
                end

        end


        function NS = GenerateConfusion(mu,sigma,featureSet)
            Return = zeros(10,10);
            load('feat.mat');

            for j=1:160
                if (featureSet==2)
                    point = f2t(1:2,j);
                    value = f2t(3,j);

                elseif (featureSet==8)
                    point = f8t(1:2,j);
                    value = f8t(3,j);

                elseif (featureSet==32)
                    point = f32t(1:2,j);
                    value = f32t(3,j);
                end

                MICDBoundary = MICDClassifier(mu, sigma, point, 10);
                Return(value, MICDBoundary) = Return(value, MICDBoundary) + 1;
            end

            NS = Return;


        end

        function K = get10RandomPrototypes(featureset, samples, classes)
            random_prototype = randperm(samples);
            K = zeros(classes, 2);
            for i = 1:length(K)
                K(i, 1) = featureset(1, random_prototype(i));
                K(i, 2) = featureset(2, random_prototype(i));
            end
        end
        
    end

end