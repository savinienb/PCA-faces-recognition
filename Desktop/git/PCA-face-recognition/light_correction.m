function Output_Image = light_correction(Image)
%Calculate the SVD
[v, h] = meshgrid(1:size(Image,1), 1:size(Image,2));
M=[v(:) h(:) v(:).*h(:) ones(numel(Image),1)]; %fill the matrix with x,y,xy,1

[U, S, D]=svd(M'*M); 

Image_value=double(reshape(Image',[],1)); %reshape as a 4*n vector by moving row by row
transform=D*(S^(-1))*U'*(M'*Image_value); %extract the ligh correction coefficient

% % % % % % % % % Apply light correction to the image
Output_Image = double(Image) - reshape(M * transform, size(Image,2), size(Image,1))';

%Normalize range for conversion to uint
%Normalize in full range
Output_Image = uint8(255*(Output_Image-min(Output_Image(:)))*(1/(max(Output_Image(:))-min(Output_Image(:)))));
