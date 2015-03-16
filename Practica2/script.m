%Practica 2 Prokudin-Gorskii

%Leer imagen 
im_or = imread('i.jpg');
%Cortar Imagen
x= size(im_or,1)/3;
x= uint32(x);
im(:,:,1) = im_or(1:x,:);
im(:,:,2) = im_or(x+1:x*2,:);
im(:,:,3) = im_or((x*2)+1:x*3,:);
%Mostrar imagenes
imshow ([im(:,:,1),im(:,:,2),im(:,:,3)]);

% To be continued
