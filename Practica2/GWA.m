% Balance de colores mediante gray world assumption

function gwa = GWA (im)

	% obtener medias
	medias =mean(mean(im));
	% Factores
	fact = [max(medias)/medias(1); max(medias)/medias(2); max(medias)/medias(3)];
	% Aplicar factores
	gwa(:,:,1) = im(:,:,1).*fact(1);
	gwa(:,:,2) = im(:,:,2).*fact(2);
	gwa(:,:,3) = im(:,:,3).*fact(3);
	% Limitar al rango [0 <= x <=255]
	gwa (gwa >255)=255;	

	figure ('name', 'GWA','NumberTitle','off')
	imshow (gwa);
end 
