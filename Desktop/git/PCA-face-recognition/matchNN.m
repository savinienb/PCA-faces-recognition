function [Face] = matchNN(Image_PCA_Test,Image_PCA_Train)

Face = zeros(size(Image_PCA_Train,2),2);

for index=1:size(Image_PCA_Train,2)
    Face(index,1) = sqrt(sum((Image_PCA_Test - Image_PCA_Train(:,index)).^2));
    Face(index,2) = index; %store the index
end

Face=sortrows(Face,1);%Put the result in order
end