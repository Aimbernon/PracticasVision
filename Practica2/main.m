%Practica 2 Prokudin-Gorskii

%Lectura de imagen
clear
im_in = imread('input2/00102v.jpg');

%Recorte de imagen
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
    if (t2(i) < 200)
            break;
        
    end
end
im_in = im_in(i:end-i,:);

% Recorte de los 3 canales

x= size(im_in,1)/3;
x= uint32(floor(x));
im(:,:,3) = im_in(1:x,:);
im(:,:,2) = im_in(x+1:x*2,:);
im(:,:,1) = im_in((x*2)+1:x*3,:);

% Preprocesado???

%Registering

%Corr_Spacial(im) - Martí Serarols 
%Corr_Fourier(im) - Alfonso Imbernon
%Corr_Fourier_Fase(im) - Raul Ramos
im_in = Corr_Norm(im); % Carles Carmona

%Preprocesado

imshow(im_in);


