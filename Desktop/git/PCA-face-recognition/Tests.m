%% LIGHT CORRECTION
sample_img = rgb2gray(imread('Test/luca4.JPG'));

light_corrected_image  = light_correction(sample_img);

figure();
subplot(1,3,1);
imshow(sample_img ,[]);
title('Original Image');
subplot(1,3,3);
imshow(light_corrected_image ,[]);
title('Light Corrected Image');

%% Transform
a = 13;

figure(1);
imshow(Original_Image_Train{a} ,[]);
figure(2);
imshow(Image_Train{a} ,[]);
hold on;
Fp = [13 20 ; 50 20 ; 34 34 ; 16 50 ; 48 50];
plot(Fp(:,1), Fp(:,2), 'r.');
hold off;

