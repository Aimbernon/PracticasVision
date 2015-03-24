function [ im_in ] = Corr_Norm( im_in )
%Implements NCC
tmp = double(im_in(:,:,1));
Cxt = conv2(tmp,conj(tmp),'same');
    for z = 1:3
        c = normxcorr2(im_in(:,:,3),conj(im_in(:,:,z)));
        [max_c, imax] = max(abs(c(:)));
        [ypeak, xpeak] = ind2sub(size(c),imax(1));
        corr_offset = [(size(im_in(:,:,1),2)-xpeak) 
                   (size(im_in(:,:,1),1)-ypeak)];
        im_in(:,:,z) = imtranslate(im_in(:,:,z),corr_offset);
    end
end

