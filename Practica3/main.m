% Practica 3: Mosaicos

% Nota: no accentos en los comentarios !!!!

% Lectura de las imagenes
files = dir('iiia/*.jpg');

for idx = 1:size(files,1)
	images(:,:,:,idx) = imread(strcat('iiia/',files(idx).name));
end

% Proyeccion cilindrica (hoy la terminare: Alfonso)
%out = Pcilindrica (images (:,:,:,1),4000);

clf;
h = imagesc(images(:,:,:,1));
axis image
[x,y] = ginput(1);

clf;
h = imagesc(images(:,:,:,2));
axis image
hold on
plot(x(:),y(:),'go');
[x2,y2] = ginput(1);

desplazamientoX = x2 - x;