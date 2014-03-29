close all;
clear all;
load('feat.mat');

rows = 256;
cols = 256;
classes = 10;
samples = 16;
featureset = 8;

[mu, sigma] = part1Funct.GetImageParameters(f8, classes, samples);

for i = 1:rows
    for j = 1:cols
        feat = [multf8(i, j, 1); multf8(i, j, 2)];
        cimage(i, j) = part1Funct.MICDClassifier(mu, sigma, feat, classes);
    end
end

figure(1);
imagesc(cimage);
figure(2);
imagesc(multim);
colormap(gray);

    