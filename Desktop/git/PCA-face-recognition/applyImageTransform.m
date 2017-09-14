function [ Image_out ] = applyImageTransform(Image_in, transform_in)
%applyImageTransform Summary of this function goes here
%   Detailed explanation goes here

[x_out, y_out] = meshgrid(1:64);

%Apply inverse transform to obtain inverse mapping
coords_in = (transform_in^-1) * [x_out(:)'; y_out(:)'; ones(1,64^2)];

% % % % % % Make x and y integer in the range of the image
x_in = round(coords_in(1,:));
y_in = round(coords_in(2,:));
x_in(x_in < 1) = 1;
x_in(x_in > size(Image_in,2))=size(Image_in,2);
y_in(y_in < 1) = 1;
y_in(y_in > size(Image_in,1))=size(Image_in,1);

% % % % % % %     Create a grid of 64*64 containing for each cell the x and
% y value to extract from the image to get a 64*64 affine transformed Image
Image_out = Image_in(sub2ind(size(Image_in), y_in, x_in));
Image_out = reshape(Image_out, 64, 64);

end

