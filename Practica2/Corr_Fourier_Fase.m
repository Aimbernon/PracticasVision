function im_out = Corr_Fourier_Fase(im)

	im_out(:,:,1) = im (:,:,1);
	%Centra las imagenes 2 y 3 en función de 1
	for i = 2:3
		%Hace la correlación de base de fourier
		result = Corr_Fase_funcion(im(:,:,1),im(:,:,i));
		%Busca el máximo
		[dy,dx]=find(result == max(max(result)));
		%Desplaza la imagen lo necesario
		%im_out(:,:,i) = Desplazar_Imagen(im(:,:,i),dx,dy);
		corr_offset = [(size(im(:,:,i),2)-dx) 
		              (size(im(:,:,i),1)-dy)];
		im_out(:,:,i) = imtranslate(im(:,:,i),corr_offset(1),corr_offset(2));
	end

	%imprime
	figure ('name', 'Corr Fourier fase','NumberTitle','off')
	imshow(im_out);
end

