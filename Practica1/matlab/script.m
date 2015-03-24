%Detector de vehiculos en imagen

%----------------------------------------------------------------------
% Tarea 1 : cargar datos:
files = dir('../input/*.jpg');
% Reserva de memoria para las imagenes
train = zeros(240,320,150);
test = zeros (240,320,150);
%Lectura de las imagenes de train y test
for idx = 1:150
    train(:,:,idx) = rgb2gray (imread(strcat('../input/',files(idx).name)));
	test(:,:,idx) = rgb2gray (imread(strcat('../input/',files(idx+150).name)));
end
%----------------------------------------------------------------------
% Tarea 2 : Media y desviación estandar "
% Calculo de la media
media = mean(train,3);
% Calculo de la desviación estandar
dstd = std (train,0,3);
% Mostrar fondo 
figure('Name','Background','NumberTitle','off')
imshow(media,[]);
%----------------------------------------------------------------------
% Tarea 3 : Segmentar los coches restando el fondo
%  Definir threshold para determinar si:
%		|x| > thr : coche
%		|x| < thr : background 
thr = input('Threshold, (Default = 60): ');
thr(isempty (thr)) = 60;
% restar el fondo a la imagen
test = double (test);
media = double (media);
img_res = bsxfun(@minus,test,media);
% Según el threshold definido, construir la imagen resultado
img_final = abs (img_res) > thr;
% Mostrar figura 1345 con el umbral determinado como ejemplo
name = strcat ('Threshold: ',int2str(thr));
figure('Name',name,'NumberTitle','off')
imshow(img_final(:,:,145));
%----------------------------------------------------------------------
% Tarea 4 : Segmentar los coches mediante modelo gausiano
alpha = input('Alpha, (Default = 0,8): ');
beta = input('Beta, (Default = 15): ');
alpha(isempty (alpha)) = 0.8;
beta(isempty (beta)) = 15;
img_final = bsxfun(@gt,abs (img_res),alpha*(dstd + beta));
% Mostrar figura 1345 con alpha y beta seleccionados como ejemplo
name = strcat ('Alpha: ',num2str(alpha),' Beta: ',int2str(beta));
figure('Name',name,'NumberTitle','off')
imshow(img_final(:,:,145));
%----------------------------------------------------------------------
% Tarea 5 : Video
% Crear video: lugar de destino y framerate
video = VideoWriter(fullfile(pwd,'shades.avi'));
video.FrameRate = 30;
open(video);
%Escribir cada frame del video con las imagenes
for i = 1:size(img_final,3)
   writeVideo(video,cast(img_final(:,:,i),'uint8'));
end
% Cerrar el video
close(video);