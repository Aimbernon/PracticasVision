%Detector de vehiculos en imagen

%----------------------------------------------------------------------
% Tarea 1 : cargar datos:
files = dir('input/*.jpg');
% Reserva de memoria para las imagenes
matrix = zeros(240,320,150);
%Lectura de las imagenes
for idx = 1:150
    color = imread(strcat('input/',files(idx).name));
    grey = rgb2gray(color);
    matrix(:,:,idx) = grey;
end
%----------------------------------------------------------------------
% Tarea 2 : Media y desviación estandar "
% Calculo de la media
media = mean(matrix,3);
% Calculo de la desviación estandar
dstd = std (matrix,0,3);
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
% Cargar imagen de val
img_val = imread ("input/in001345.jpg");
img_val = rgb2gray (img_val);
% restar el fondo a la imagen
img_val = double (img_val);
media = double (media);
img_res = imsubtract (img_val,media);
% Según el threshold definido, construir la imagen resultado
img_res = abs (img_res) > thr;
% Mostrar figura con el umbral determinado
name = strcat ('Threshold: ',int2str(thr));
figure('Name',name,'NumberTitle','off')
imshow(img_res);
%----------------------------------------------------------------------
% Tarea 4 : Segmentar los coches mediante modelo gausiano
alpha = 0.009;
beta = 3;
img_res = abs (img_res) > alpha*(dstd + beta);
% Mostrar figura con alpha y beta seleccionados
name = strcat ('Alpha: ',num2str(alpha),' Beta: ',int2str(beta));
figure('Name',name,'NumberTitle','off')
imshow(img_res);

%----------------------------------------------------------------------
% Tarea 5 : Video


