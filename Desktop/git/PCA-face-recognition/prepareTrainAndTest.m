function [PCA_Train, PCA_Test] = prepareTrainAndTest(Image_Train, Feature_Train, Image_Test, Feature_Test )
%PROJECTION Summary of this function goes here
%   Detailed explanation goes here

disp(' Normalizing the images')
Norm_Train = normalizeImages(Feature_Train, Image_Train);
Norm_Test = normalizeImages(Feature_Test, Image_Test);

%Get the projection base for dimensionality reduction
disp(' Computing the PCA projection base')
projectionBase = getPCABase(Norm_Train);

disp(' Projecting the training Images')
PCA_Train = projectPCABase(Norm_Train, projectionBase);

disp(' Projecting the test Images')
PCA_Test = projectPCABase(Norm_Test, projectionBase);

disp('Finished Training');
end
