box3 = 1/9.*ones(3);
box5 = 1/9.*ones(5);
gaussian = 1/16 .* [1 2 1; 2 4 2; 1 2 1];
laplacian = -0.5 .* [1 1 1; 1 -8 1; 1 1 1];

lena = struct2array(open('lena512.mat'));
box_lena3 = conv2(box3,lena);
box_lena5 = conv2(box5,lena);
gauss_lena = conv2(gaussian,lena);
lap_lena = conv2(laplacian, lena);

subplot(2,3,1); imagesc(lena); title('Original');
subplot(2,3,2); imagesc(box_lena3); title('Box Blur 3x3');
subplot(2,3,3); imagesc(gauss_lena); title('Gaussian Blur');
subplot(2,3,4); imagesc(lap_lena); title('Laplacian Blur');
subplot(2,3,5); imagesc(box_lena5); title('Box Blur 5x5');
colormap('gray')

lena_ft = fft2(lena);
lena_np_ft = zeros(512);
lena_unity_ft = zeros(512);
lena_mag = zeros(512);
for row = 1:512;
    for col = 1:512;
        lena_np_ft(row,col) = abs(lena_ft(row,col));
        phase = angle(lena_ft(row,col));
        lena_mag(row,col) = abs(lena_ft(row,col));
        lena_unity_ft(row,col) = cos(phase)+i*sin(phase);
    end
end
lena_np = ifft2(lena_np_ft);
lena_unity = lena_mag.*real(ifft(lena_unity_ft));
figure
subplot(1,2,1); imagesc(lena_np); title('No Phase');
subplot(1,2,2); imagesc(lena_unity); title('Zero Magnitude')

noisy = imread('boy_noisy.gif', 'Frames', 'all');
imshow(noisy)
noisy_fft = fftshift(fft2(noisy));
%mesh(log(1+abs(noisy_fft)))

filter = ones(512);
filter = surroundings2zero(filter,273,225);
filter = surroundings2zero(filter,241,225);
filter = surroundings2zero(filter,273,289);
filter = surroundings2zero(filter,241,289);

noisy_clean_ft = filter .* noisy_fft;
clean = ifft2(ifftshift(noisy_clean_ft));
imagesc(clean)
