function [ result ] = Corr_Fase_funcion( im1, im2 )

%Setup de widows
filter1=blackman(size(im1,1));
filter2=blackman(size(im1,2));

%2D windowing
filtimg1=(filter1*filter2');
im1=double(im1).*filtimg1; 
im2=double(im2).*filtimg1;

%Fourier
FFT1 = fft2(im1); 
FFT2 = fft2(im2);

% Obtener fase de cada imagen
fase1 = angle(FFT1);
fase2 = angle(FFT2);

% Resta de las fases
fs = exp (i*(fase1 -fase2));

result = real (ifft2(double(fs)));

end

