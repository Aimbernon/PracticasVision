%Practica 2 Prokudin-Gorskii: Correlacion en fourier

function im_out = Corr_Fourier( im )

	ff1 = fft2 (im (:,:,1));
	im_out(:,:,1) = im(:,:,1);
	for i = 2:3
		% Tranformar al espacio de fourier
		ff2 = fft2 (im (:,:,i));
	
		% Producto de las imagenes
		ff2 = conj(ff2);
		ff = ff1.*ff2;
		ff = ff./abs(ff);
		ff =ifft2 (double (ff));

		% Obtener la posicion del maximo y desplazar la imagen
		[c,indice] = max (abs(ff(:)));
		[ypeak, xpeak] = ind2sub(size(ff),indice(1));
		corr_offset = [(size(im(:,:,i),2)-xpeak) 
		              (size(im(:,:,i),1)-ypeak)];
		im_out(:,:,i) = imtranslate(im(:,:,i),corr_offset(1),corr_offset(2));
	end
	% Comprovación del resultado con la img en color sin corr
	figure ('name', 'Corr fourier','NumberTitle','off')
	imshow (im_out);
end
