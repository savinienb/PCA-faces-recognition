function [Image_dic]=normalizeImages(Features,Image);

% % % % % % % % % Train the algorithm
Transform = cell([1 length(Image)]);
Image_dic = cell([1 length(Image)]);

for i=1:length(Image)   
    Transform{i} = computeLMStransform(Features{i},100,.001);
    Image_dic{i} = applyImageTransform(Image{i}, Transform{i});
    Image_dic{i} = light_correction( Image_dic{i} );
end