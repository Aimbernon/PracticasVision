
%Leer imagen 
im_or = imread('0146.jpg');
%Cortar Imagen
x= size(im_or,1)/3;
x= uint32(x);
im1 = im_or(1:x,:,:);
im2 = im_or(x+1:x*2,:);
im3 = im_or((x*2)+1:x*3,:);
%Mostrar imagenes
figure,
subplot(1,3,1), imshow(im1);title('Figure 1');
subplot(1,3,2), imshow(im2);title('Figure 2');
subplot(1,3,3), imshow(im3);title('Figure 3');

%%%%%%%%%%%%Centra las imagenes 2 y 3 en función de 1
%Hace la correlación de base de fourier
result = Corr_Fase_funcion(im1,im2)
%Busca el máximo
[dy,dx]=find(result == max(max(result)))
%Desplaza la imagen lo necesario
f2 = Desplazar_Imagen(im2,dx,dy)

%Hace la correlación de base de fourier
result = Corr_Fase_funcion(im1,im3)
%Busca el máximo
[dy,dx]=find(result == max(max(result)))
%Desplaza la imagen lo necesario
f3 = Desplazar_Imagen(im3,dx,dy)



%Se pueden imprimir las imágenes desplazadas si se quiere
%{
figure,
subplot(1,3,1), imshow(im1);title('Figure 1');
subplot(1,3,2), imshow(f2);title('Figure 2');
subplot(1,3,3), imshow(f3);title('Figure 3');
%}

%%%%%%%%%%%Junta los tres canales e imprime
f = cat(3, f3, f2, im1);
figure, imshow(f)