function [Eigenvectors] = getPCABase(TrainImages)

% % %Rewrite all the matrix into vectors and store them

if iscell(TrainImages)==0 %Check if the variable is a cell 
    Images_values=double(reshape(TrainImages,1,[]));
else
    Images_values = zeros(length(TrainImages), 4096);

    % Flatten the image pixels and stack them for PCA
    for index=1:length(TrainImages)
        Images_values(index, :) = double(reshape(TrainImages{index}, 1, 4096));    
    end    
end

Image_mean=mean(Images_values,1);

% Substract the mean
Imagelessmean=bsxfun(@minus, Images_values, Image_mean);
Image_cov=(1/(size(Imagelessmean,2)-1))*(Imagelessmean'*Imagelessmean);

[Eigenvectors eigenvalues]=eig(Image_cov);
end


