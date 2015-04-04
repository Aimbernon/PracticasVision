function out = Corr_Spacial (im)
	
	out(:,:,1)= im(:,:,1);
	for i = 2:3
		c = conv2(im(:,:,1),conj(im(:,:,i)));
    	[max_c, imax] = max(abs(c(:)));
    	[ypeak, xpeak] = ind2sub(size(c),imax(1));
    	corr_offset = [(size(im(:,:,1),2)-xpeak) 
               (size(im(:,:,1),1)-ypeak)];
    	out(:,:,i) = imtranslate(im(:,:,i),corr_offset(1),corr_offset(2));
	end
	figure ('name', 'Corr Spacial','NumberTitle','off')
	imshow (out);
end

