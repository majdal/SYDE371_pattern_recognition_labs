close all;
clear all;

load feat.mat

samples = 160;
classes = 10;
K = part1Funct.get10RandomPrototypes(f32, samples, classes);

classified = zeros(samples, 1);
K_archive = K;
K_old = zeros(size(K));
K_diff = 1;

while K_diff > 0
    K_old = K;
    
    for i=1:samples
        proto_Dist = zeros(classes, 1);
        for j=1:classes
            proto_Dist(j, 1) = (f32(1, i) - K(j, 1))^2 + (f32(2, i) - K(j, 2))^2;
        end
        [minValue, minIndex] = min(proto_Dist);
        classified(i) = minIndex;
    end
    K = zeros(classes, 2);
    for i=1:classes
        count = 0;
        for j=1:samples
            if classified(j, 1) == i
                K(i, 1) = K(i, 1) + f32(1, j);
                K(i, 2) = K(i, 2) + f32(2, j);
                count = count + 1;
            end
        end
        K(i, :) = K(i, :)./count;
    end
    K_diff = sum(sum(K_old ~= K));
end

figure;
hold on;
aplot(f32);
plot(K_archive(:,1), K_archive(:,2), 'rs', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','r', 'MarkerSize',5);
title('K-means Algorithm for Unlabeled Clusters');
plot(K(:,1), K(:,2), 'rs', 'MarkerEdgeColor', 'k', 'MarkerFaceColor','b', 'MarkerSize',5);
title('K-means Algorithm Applied To Unlabeled Clusters');
axis([0 0.16 0 0.2]);
legend('Inital Prototype Position', 'Final Prototype Position', 4);
hold off;

        
        
            
