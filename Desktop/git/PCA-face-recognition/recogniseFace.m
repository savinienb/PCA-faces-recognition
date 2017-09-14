function [faceScores] = recogniseFace(idx_test_image, labels_test, PCA_Test_Images, labels_train, PCA_Train_Images, n_eig)

%PROJECT INTO N_EIG
PCA_Test_Images = PCA_Test_Images(1:n_eig, :);
PCA_Train_Images = PCA_Train_Images(1:n_eig, :);

faceScores = matchNN(PCA_Test_Images(:, idx_test_image), PCA_Train_Images);

%Add new row for storing accuracy percentage
faceScores(:,3) = zeros(size(PCA_Train_Images,2),1);

%ERROR percentage computation
minScore = faceScores(1,1);
worstScore = faceScores(end,1);

for i=1:size(PCA_Train_Images,2)
    % Calculate the error
    faceScores(i,3)=(1-(faceScores(i,1)-minScore)/(worstScore-minScore))*100;
end

end