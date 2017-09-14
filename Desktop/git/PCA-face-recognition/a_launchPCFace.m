
num_eigenvalues = 90;

if( ~exist('database_loaded', 'var'))
    [Original_Image_Train, Feature_Train, Name_Train] = loadDataFolder('Train/');
    [Original_Image_Test, Feature_Test, Name_Test] = loadDataFolder('Test/');
    
    [Image_Train] = normalizeImages(Feature_Train, Original_Image_Train);
    [Image_Test] = normalizeImages(Feature_Test, Original_Image_Test);
    
    database_loaded = 1;
end

GUI();