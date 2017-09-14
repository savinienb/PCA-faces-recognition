
%[Image_Train Feature_Train Name_Train]=loadDataFolder('Train/');
%[Image_Test Feature_Test Name_Test]=loadDataFolder('Test/');
%[PCA_Train PCA_Test]=prepareTrainAndTest(Image_Train,Feature_Train,Image_Test,Feature_Test);


num_eigs = [1:1:150];
k = zeros(length(num_eigs), length(Image_Test));


for eigen_index=1:length(num_eigs)
    eig = num_eigs(eigen_index);
    disp(eig);    
    
    for index=1:length(Image_Test)
        %Get ranking of faces
        Face = recogniseFace(index, Name_Test, PCA_Test, Name_Train, PCA_Train, eig);
        
        %Check were correct label is placed
        for candidateFace = 1:length(Face)
            if strcmp(Name_Test{index}, Name_Train{Face(candidateFace,2)})
                k(eigen_index, index) = candidateFace;
                break;
            end
        end
    end
end


num_k = [1 3 5];
accuracy = zeros(length(num_eigs), length(num_k));

figure(1); hold on;
for i = 1:length(num_k)
    accuracy(:,i) = (1 - sum(k > num_k(i), 2)/length(Image_Test))*100;
end

plot(accuracy(:,1), 'b');
plot(accuracy(:,2), 'r');
plot(accuracy(:,3), 'g');
legend('k = 1', 'k = 3', 'k = 5');
ylabel('Accuracy (%)');
xlabel('Number of Components');
hold off;


%% Compute accuracy according to book

k2 = (k <= 2);
