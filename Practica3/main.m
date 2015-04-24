% Practica 3: Mosaicos

% Nota: no accentos en los comentarios !!!!

% Lectura de las imagenes
files = dir('iiia/*.jpg');

for idx = 1:size(files,1)
	images(:,:,:,idx) = imread(strcat('iiia/',files(idx).name));
end

% Proyeccion cilindrica (hoy la terminare: Alfonso)
out = Pcilindrica (images (:,:,:,1),4000);

imshow (out);