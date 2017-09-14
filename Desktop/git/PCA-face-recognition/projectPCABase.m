function [ PCA_Projection ] = projectPCABase( Images, Eigenvectors )
%PROJECTPCABASE Summary of this function goes here
%   Detailed explanation goes here

% % %Rewrite all the matrix into vectors and store them
if iscell(Images)==0 %Check if the variable is a cell 
    Images_values=double(reshape(Images,1,[]));
else
    Images_values = zeros(length(Images), 4096);

    % Flatten the image pixels and stack them for PCA
    for index=1:length(Images)
        Images_values(index, :) = double(reshape(Images{index}', 1, 4096));    
    end    
end

PCA_Projection = (Images_values*Eigenvectors)';
end

