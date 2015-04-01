
%Leer imagen 
im_or = imread('i.jpg');
%Cortar Imagen
x= size(im_or,1)/3;
x= uint32(x);
im1 = im_or(1:x,:,:);
im2 = im_or(x+1:x*2,:);
im3 = im_or((x*2)+1:x*3,:);
%Mostrar imagenes
%subplot(1,3,1), imshow(im1);title('Figure 1');
%subplot(1,3,2), imshow(im2);title('Figure 2');
%subplot(1,3,3), imshow(im3);title('Figure 3');

image1 = im1; % read image 1 (convert to grayscale if RGB)
image2 = im2; % read image 2 must have same dimensions as image 1
filter1=blackman(size(image1,1),'symmetric'); % setup window in one direction - I chose Blackman window - could use Hamming or others
filter2=blackman(size(image1,2),'symmetric'); % setup window in second direction
filtimg1=(filter1*filter2'); % make 2D windowing function that is sized to match image
Image1=double(image1).*filtimg1; % apply windowing function to image
Image2=double(image2).*filtimg1;
FFT1 = fft2(Image1); % 2d FFT
FFT2 = conj(fft2(Image2));
FFTR = FFT1.*FFT2;
magFFTR = abs(FFTR);
FFTRN = (FFTR./magFFTR);
result = ifft2(double(FFTRN));
figure;
colormap('gray'); % choose colormap for plotting
%imagesc(result);


[dy,dx]=find(result == max(max(result)))

img = im2
T = maketform('affine', [1 0 0; 0 1 0; dx dy 1]);   %# represents translation
img2 = imtransform(img, T, ...
    'XData',[1 size(img,2)], 'YData',[1 size(img,1)]);
subplot(121), imshow(img)
subplot(122), imshow(img2)