% Practica 3: Mosaicos

% Nota: no accentos en los comentarios !!!!
clear,close all;
%IIIA
%files = dir('iiia/*.jpg');
% for idx = 1:size(files,1)
% 	images(:,:,:,idx) = imread(strcat('iiia/',files(idx).name));
% end

%ETSE
files = dir('etse/*.jpg');
for idx = 1:size(files,1)
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
out = PPlanaAut(images);

% Proyeccion cilindrica (hoy la terminare: Alfonso)
%out = Pcilindrica (images (:,:,:,1),4000);

imshow(out);