function out =Equalization (im)	
	for i= 1:3
		out (:,:,i)=histeq(im(:,:,i));
	end
	% mostrar resultado
	figure ('name', 'Ecualización','NumberTitle','off')
	imshow (out);
end
