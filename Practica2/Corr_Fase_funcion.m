function [ result ] = Corr_Fase_funcion( im1, im2 )

%Setup de widows
filter1=blackman(size(im1,1),'symmetric');
filter2=blackman(size(im1,2),'symmetric');

%2D windowing
filtimg1=(filter1*filter2');
im1=double(im1).*filtimg1; 
im2=double(im2).*filtimg1;

%Fourier
FFT1 = fft2(im1); 
FFT2 = conj(fft2(im2));
FFTR = FFT1.*FFT2;
magFFTR = abs(FFTR);
FFTRN = (FFTR./magFFTR);
result = ifft2(double(FFTRN));

%Impresión
figure;
colormap('gray');
imagesc(result);

end

