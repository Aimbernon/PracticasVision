% Practica 3: Mosaicos

% Nota: no accentos en los comentarios !!!!
clear,close all;
%IIIA
% files = dir('iiia/*.jpg');
% for idx = 1:4
% 	images(:,:,:,idx) = imread(strcat('iiia/',files(idx).name));
% end

%ETSE
files = dir('etse/*.jpg');
for idx = 1:4
	images(:,:,:,idx) = imread(strcat('etse/',files(idx).name));
end

%CUSTOM_SET1
% files = dir('custom_set1/*.jpg');
% for idx = 1:size(files,1)
% 	images(:,:,:,idx) = imread(strcat('custom_set1/',files(idx).name));
% end

%CUSTOM_SET2
%  files = dir('custom_set2/*.jpg');
%  for idx = 1:size(files,1)
%  	images(:,:,:,idx) = imread(strcat('custom_set2/',files(idx).name));
%  end

%Proyeccion Plana Manual
%out = PPlanaMan(images);
%Proyeccion Plana Automatica
%ouimshow(out);
% out = PPlanaAut(images);

% Proyeccion cilindrica
aux = Pcilindrica (images (:,:,:,1),2500);
aux2 = Pcilindrica (images (:,:,:,2),2500);
out =Unir_cyl(aux,aux2,1);
for idx =3:4
aux3 = Pcilindrica (images (:,:,:,idx),2500);
out =Unir_cyl(out,aux3,1);
end

imshow(out);
%imshow(out);