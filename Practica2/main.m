%Practica 2 Prokudin-Gorskii

%Lectura de imagen
clear
im_in = imread('input2/0109.jpg');

%Recorte de imagen
% opcion 1
%Hacemos la media por columnas i filas para detectar canvios a negros o
%claros (Por desarollar), otra idea puede ser hacer una media de todo el
%dataset y cortar siempre el mismo valor o un mix de las dos xD

t=mean(im_in);
j=0;
for i = 1:size(im_in,2)
    if (t(i)>120) &&  (t(i) < 150)
        j=j+1;
        if (j==2)
            break;
        end
    end
end
if (i>40)
    i=20;
end
im_in = im_in(:,i:end-i);

t2 = mean(im_in,2);
j=0;
for i = 1:size(im_in,2)
    if (t2(i) < 200 )
            break;
        
    end
end
im_in = im_in(i:end-i,:);
figure
imshow (im_in)

% opcion 2 : determinar si es borde o no por el num de veces que el valor
% de la columna/ fila esta entre 0:40. En ese caso se elimina la fila/columna

im_in = imread('input2/0109.jpg');
% contar cuantas veces el valor del pixel esta entre el intervalo
ccol = sum(histc (im_in,[0:40]));
crows = sum(histc (im_in',[0:40]));
% eliminacion de los bordes
thx=size (im_in,1).*0.8;
thy=size (im_in,2).*0.8;
im_in(:,ccol>thx)=[];
im_in (crows>thy,:)=[];

figure ('name', 'Eliminacion de los bordes','NumberTitle','off')
imshow (im_in);
% Recorte de los 3 canales

x= size(im_in,1)/3;
x= uint32(floor(x));
im(:,:,3) = im_in(1:x,:);
im(:,:,2) = im_in(x+1:x*2,:);
im(:,:,1) = im_in((x*2)+1:x*3,:);

% Preprocesado???

%Registering
tic();
out =Corr_Spacial(im); %- Martí Serarols 
tiempos(1)=toc();
%tic();
%out =Corr_Fourier(im); % - Alfonso Imbernon
%tiempos(2)=toc();
%tic();
%out =Corr_Fourier_Fase(im);% - Raul Ramos
%tiempos(3)=toc();
%tic();
%im_in = Corr_Norm(im); % Carles Carmona
%tiempos(4)=toc();
%tiempos
%plot ([1:4],tiempos);
%Postprocesado
out_e = Equalization(out);
out_gwa = GWA (out);



