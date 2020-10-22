%========================================================
%
%       HOSVD Main
%       BY KazukiAmakawa(with Image Patch Method)
%
%========================================================
clc;
clear;
%========================================================
%Setting Parameter
para_sigma       = 5;
patch_method     = 31;
para_iteration   = 5;

if para_sigma == 80
    para_betta       = 0.1
    para_gamma       = 0.35
    para_patch_size  = 10
    para_patch_stack = 35
    para_iteration   = 10
elseif para_sigma == 50
    para_betta       = 0.1
    para_gamma       = 0.35
    para_patch_size  = 9
    para_patch_stack = 35
elseif para_sigma == 30
    para_betta       = 0.1
    para_gamma       = 0.3
    para_patch_size  = 7
    para_patch_stack = 25
elseif para_sigma == 10
    para_betta       = 0.16
    para_gamma       = 0.28
    para_patch_size  = 7
    para_patch_stack = 25
elseif para_sigma == 5
    para_betta       = 0.1
    para_gamma       = 0.35
    para_patch_size  = 7
    para_patch_stack = 20
    patch_method     = 34
end
%para_gamma       = 0.67;

para_iteration   = 5;
test_switch      = 0
if patch_method == 34
    para_patch_stack = 100
end
if patch_method == 35
    para_patch_stack = 20
end

%Method list
%patch_method = 1: Original method NNM patch search 
%patch_method = 2x: Pre-trained Gaussian Mixture Model method
%patch_method = 3x: Pre-trained GMM and K-means method
%patch_method = x1: BFS after classification search
%patch_method = x2: None search after classification
%patch_method = 33: None search after classification
%========================================================
%Read Initial File

img = double(imread('figure/orig_cir.png'));
img = img / 255;
img_size = size(size(img));
if img_size(1, 2) == 3
    img = rgb2gray(img);
end

%========================================================
%Read noise

image_with_noise = double(imread('figure/noise_cir.png'));
image_with_noise = image_with_noise / 255;
if img_size(1, 2) == 3
    image_with_noise = rgb2gray(image_with_noise);
end

%========================================================
%Algorithm

image_with_noise   = imresize(image_with_noise, size(image_with_noise) * 2);
[result_img, PSNR] = Image_HOSVD_Denoising(255 * image_with_noise, 255 * img, para_sigma, para_betta, para_gamma, para_patch_size, para_patch_stack, para_iteration, patch_method);

%========================================================
%Show Result

imwrite(result_img_1 / 255, 'figure/denoised_cir.png', 'png');

%fprintf('PSNR: %d\n', PSNR);
