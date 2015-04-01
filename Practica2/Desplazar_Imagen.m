function [ imgT ] = Desplazar_Imagen( img, dx, dy )

T = maketform('affine', [1 0 0; 0 1 0; dx dy 1]);   %# represents translation
imgT = imtransform(img, T, ...
    'XData',[1 size(img,2)], 'YData',[1 size(img,1)]);
subplot(121), imshow(img)
subplot(122), imshow(imgT)

end

